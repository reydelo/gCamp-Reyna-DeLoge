class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @memberships = Membership.all
    @users = User.all
    @membership = @project.memberships.new
  end

  private
  def memberships_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
