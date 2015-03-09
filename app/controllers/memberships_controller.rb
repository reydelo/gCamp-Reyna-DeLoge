class MembershipsController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @memberships = Membership.all
  end

end
