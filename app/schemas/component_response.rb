class ComponentResponse < RubyLLM::Schema
  object :component do
    string :html, description: "Plain html code"
    string :css, description: "Plain css code"
  end
end
