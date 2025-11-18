class ComponentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @components = @project.components
  end

  def preview
    @component = Component.find(params[:id])
    render layout: false
  end
end
