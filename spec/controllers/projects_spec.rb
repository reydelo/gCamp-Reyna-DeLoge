require 'rails_helper'

describe ProjectsController do
  describe "GET #show" do
    before do
      @project = Project.create(name: "My sweet project")
    end

    context "admin can view projects" do
      before do
        @admin = User.create( first_name: "Admin", last_name: "User", email: "admin.user@example.com",
        password: "password", password_confirmation: "password", admin: true)
        session[:user_id] = @admin.id
      end

      it "renders project_show" do
        get :show, id: @project.id

        expect(response).to be_success
      end
    end

    context "Non admin cannot see projects if user is not an admin" do
      it "redirects me to the signin" do
        get :show, id: @project.id

        expect(response).to be_redirect
        expect(response).to redirect_to login_path
      end
    end

    context "does not belong to project" do
      it "redirects me to the projects index" do
        user = User.create( first_name: "Suzie", last_name: "Tuesday", email: "user@example.com", password: "password", password_confirmation: "password")
        session[:user_id] = user.id

        get :show, id: @project.id

        expect(response).to redirect_to projects_path
      end
    end


  end
end
