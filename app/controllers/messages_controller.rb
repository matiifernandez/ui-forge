class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
"You are an expert Front-end Developer.
Your job is to generate UI components based on the user’s description.

Always return your answer as a strict JSON object with this exact structure:

{
  "html": "<!-- HTML code here, no markdown, no backticks -->",
  "css": "/* CSS code here, no markdown, no backticks */"
}

Requirements:
- Do NOT use markdown.
- Do NOT use code fences (no ```).
- Do NOT add commentary or explanations.
- Only return valid JSON.
- Escape quotes inside the HTML and CSS values."
- Do not add newline characters. e.g. \n
PROMPT

  def create
    @chat = Chat.find(params[:chat_id])
    @component = @chat.component
    @message = Message.new(message_params)
    @project = @component.project
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      response = @ruby_llm_chat.with_instructions(instructions).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
      respond_to do |format|
        format.html { redirect_to chat_messages_path(@chat) }
        format.turbo_stream { render 'create' }
      end
    else
      render 'chats/show', status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message({
        role: message.role,
        content: message.content
      })
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def instructions
    SYSTEM_PROMPT
  end
end
