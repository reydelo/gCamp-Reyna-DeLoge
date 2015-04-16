require 'rails_helper'

describe 'User can CRUD Projects' do

  before :each do

    @user = User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{@user.email}"
    fill_in 'Password', :with => "#{@user.password}"
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

  scenario 'Admin user can CRUD projects' do

    click_on 'Logout'
    admin = User.create(email: 'admin@email.com', password: 'password', first_name: 'Admin', last_name: 'User', admin: true)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{admin.email}"
    fill_in 'Password', :with => "#{admin.password}"
    click_button 'Login'

    visit '/projects'
    within ".pull-right" do
      click_on "New Project"
    end
    fill_in 'Name', with: 'Admin Project'
    click_on 'Create Project'
    expect(page).to have_content('Project was successfully created.')

    visit '/projects'
    within "table" do
      click_on "#{@project.name}"
    end
    expect(page).to have_content("#{@project.name}")
    within ".pull-right" do
      click_on 'Edit'
    end
    fill_in 'Name', with: 'gCamp by Reyna - Completed'
    click_on 'Update Project'
    expect(page).to have_content('Project was successfully updated')

    visit '/projects'
    @project.reload
    within "table" do
      click_on "#{@project.name}"
    end
    click_on 'Delete'
    expect(page).to have_content('Project was successfully destroyed')

  end

end
