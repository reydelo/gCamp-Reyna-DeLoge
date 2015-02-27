class ProjectsController < ApplicationController
  before_filter :authenticate

def authenticate
  redirect_to(signup_path) unless current_user
end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path(@project), notice: 'Project was successfully created.'
    else
    render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully destroyed.'
    end
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
