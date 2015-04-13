class MembershipsController < ApplicationController

  before_action :set_project, only: [:index, :create, :update, :destroy]
  before_action :permissions
  layout "internal"

  def index
    @membership = @project.memberships.all
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(memberships_params)
    @membership.project_id = params[:project_id]
    @membership.project_id = @project.id
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(memberships_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated"
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    if @membership.destroy
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully deleted"
    else
      render :index
    end
  end

  private
  def memberships_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def permissions
    if current_user.projects.include?(@project) == false
      redirect_to projects_path, alert: 'You do not have access to that project'
    end
  end

end
