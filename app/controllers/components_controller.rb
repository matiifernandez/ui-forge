class ComponentsController < ApplicationController

  before_action :set_project, only: %i[new create]

  def index
    @project = Project.find(params[:project_id])
    @components = @project.components
  end

  def preview
    @component = Component.find(params[:id])
    render layout: false
  end

  def new
    @project = Project.find(params[:project_id])
    @component = Component.new
  end

  def create
    @project.user = current_user
    @project = Project.find(params[:project_id])
    @component = Component.new(component_params)
    @component.project = @project
    if @component.save
      redirect_to project_component_path(@project, @component)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def component_params
    params.require(:component).permit(:name, :html_code, :css_code)
  end
end
