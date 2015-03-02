require 'rails_helper'

describe 'User can CRUD users' do

  before :each do

    User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'aaron.rodgers@gbqb.com'
    fill_in 'Password', :with => 'touchdown'
    click_button 'Login'
    Project.create(name: 'gCamp - User 1')
    click_on 'Projects'
  end

  scenario 'Users can create a project' do

    click_on 'New Project'
    fill_in 'Name', with: 'gDemo - User 1'
    click_on 'Create Project'
    expect(page).to have_content('Project was successfully created.')
  end

  scenario 'Users can show/edit a project' do

    click_on 'gCamp - User 1'
    expect(page).to have_content('gCamp - User 1')
    click_on 'Edit'
    fill_in 'Name', with: 'gCamp by Reyna '
    click_on 'Update Project'
    expect(page).to have_content('Project was successfully updated')
  end

  scenario 'Users can delete a project' do

  click_on 'gCamp - User 1'
  click_on 'Delete'
  expect(page).to have_content('Project was successfully destroyed')
end

end