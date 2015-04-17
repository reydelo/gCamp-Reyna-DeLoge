class TasksController < ApplicationController
  before_action :authenticate
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :permissions

  def new
    @task = Task.new
    render layout: "internal"
  end

  def index
    @tasks = Task.all
    render layout: "internal"
  end

  def show
    @comment = Comment.new
    @comments = @task.comments.all
    render layout: "internal"
  end

  def edit
    render layout: "internal"
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
    if @task.save
      redirect_to project_task_path(project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    redirect_to project_tasks_path(project), notice: 'Task was successfully destroyed.'
  end

  private
  def set_task
    @task = Task.find(params[:id])
    @project = project
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :date, :complete, :project_id)
  end

  def permissions
    unless current_user.projects.include?(project) || admin
      redirect_to projects_path, alert: 'You do not have access to that project'
    end
  end

end
