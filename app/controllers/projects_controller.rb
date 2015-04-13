class ProjectsController < ApplicationController
  layout "internal"
  before_filter :authenticate
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :permissions, except: [:index, :new, :create]

  def authenticate
    redirect_to(signup_path) unless current_user
  end

  def index
    @projects = current_user.projects.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @membership = Membership.new(project_id: @project.id, user_id: current_user.id, role: 1)
      @membership.save
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully destroyed.'
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

  def permissions
    if current_user.projects.include?(@project) == false
      redirect_to projects_path, alert: 'You do not have access to that project'
    end
  end

end
