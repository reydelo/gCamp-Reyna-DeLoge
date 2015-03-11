class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @memberships = Membership.all
    @users = User.all
    @membership = Membership.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(memberships_params)
    @membership.project_id = params[:project_id]
    @membership.user_id = params[:membership][:user_id]
    @user = User.find_by(params[:id])
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added"
    else
      render :index
    end
  end

  private
  def memberships_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
