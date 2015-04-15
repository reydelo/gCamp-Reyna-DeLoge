require 'rails_helper'

describe 'User can CRUD users' do

  before :each do

    @user = User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'aaron.rodgers@gbqb.com'
    fill_in 'Password', :with => 'touchdown'
    click_button 'Login'
    @project = Project.create(name: 'gCamp - User 1')
    Membership.create(user_id: @user.id, project_id: @project.id, role: 1)
    visit '/projects'
  end

  scenario 'Users can create a project' do

    within ".pull-right" do
      click_on "New Project"
    end
    fill_in 'Name', with: 'gDemo - User 1'
    click_on 'Create Project'
    expect(page).to have_content('Project was successfully created.')
  end

  scenario 'Users can show a project, and edit project if owner' do

    within "table" do
      click_on "#{@project.name}"
    end
    expect(page).to have_content("#{@project.name}")
    click_on 'Edit'
    fill_in 'Name', with: 'gCamp by Reyna '
    click_on 'Update Project'
    expect(page).to have_content('Project was successfully updated')
  end

  scenario 'Users can delete a project if owner' do

    within "table" do
      click_on "#{@project.name}"
    end
    click_on 'Delete'
    expect(page).to have_content('Project was successfully destroyed')
  end

end
