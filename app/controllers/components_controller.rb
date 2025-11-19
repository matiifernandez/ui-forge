class ComponentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @components = @project.components
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy
    redirect_to component_path, notice: "the component #{@component.name} was deleted"
  end
  def preview
    @component = Component.find(params[:id])
    render layout: false
  end
end
