class TasksController < ApplicationController
  before_filter :authenticate

  def authenticate
    redirect_to(signup_path) unless current_user
  end

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def index
    @project = Project.find(params[:project_id])
    @tasks = Task.all
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @project = Project.find(params[:project_id])
    @task.project_id = params[:project_id]
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :date, :complete, :project_id)
  end
  
end
