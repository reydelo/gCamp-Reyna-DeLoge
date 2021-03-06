require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do

    @user = User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    @outsider = User.create(email: 'a@rob.com', password: 'password', first_name: 'A', last_name: 'Rob')
    @project = Project.create(name: 'gSchool Demo')
    Membership.create(user_id: @user.id, project_id: @project.id)
    @task = Task.create(description: 'Go to yoga', date: '2015/03/17', project_id: @project.id)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{@user.email}"
    fill_in 'Password', :with => "#{@user.password}"
    click_button 'Login'
    task_count = @project.tasks.count
    visit "/projects/#{@project.id}/tasks"
  end

  scenario 'Users can create a task' do

    click_on 'New Task'
    fill_in 'Description', with: 'Get your shit done!'
    click_button 'Create Task'
    expect(page).to have_content('Task was successfully created.')
    expect(page).to have_content('Get your shit done!')
  end

  scenario 'Outsiders cannot view/edit a task if not a project member' do

    click_on 'Logout'
    click_on 'Login'
    fill_in 'Email', :with => "#{@outsider.email}"
    fill_in 'Password', :with => "#{@outsider.password}"
    click_button 'Login'
    visit "/projects/#{@project.id}/tasks"
    expect(page.current_path).to eq projects_path
    expect(page).to have_content('You do not have access to that project')
    visit "/projects/#{@project.id}/tasks/#{@task.id}"
    expect(page.current_path).to eq projects_path
    expect(page).to have_content('You do not have access to that project')
    visit "/projects/#{@project.id}/tasks/#{@task.id}/edit"
    expect(page.current_path).to eq projects_path
    expect(page).to have_content('You do not have access to that project')
  end

  scenario 'Users can edit a task' do

    click_on 'Edit'
    fill_in 'Description', with: 'Go to yoga - Namaste'
    click_button 'Update Task'
    expect(page).to have_content('Task was successfully updated.')
    expect(page).to have_content('Go to yoga - Namaste')
  end

  scenario 'Users can show a task' do

    click_on "#{@task.description}"
    expect(page).to have_content("#{@task.description}")
    expect(page).to have_content("#{@task.date.to_formatted_s(:long)}")
  end

  scenario 'Users can delete a task' do

    page.click_link('', :href => "/projects/#{@task.project_id}/tasks/#{@task.id}")
    expect(page).to have_content('Task was successfully destroyed.')
  end

  scenario 'Admin user can CRUD projects' do

    click_on 'Logout'
    admin = User.create(email: 'admin@email.com', password: 'password', first_name: 'Admin', last_name: 'User', admin: true)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{admin.email}"
    fill_in 'Password', :with => "#{admin.password}"
    click_button 'Login'
    visit "/projects/#{@project.id}/tasks"
    click_on 'New Task'
    fill_in 'Description', with: 'lightning Talk for friday meeting'
    click_button 'Create Task'
    expect(page).to have_content('Task was successfully created.')
    expect(page).to have_content('lightning Talk for friday meeting')
    click_on 'Edit'
    fill_in 'Description', with: 'Go to yoga - Namaste'
    click_button 'Update Task'
    expect(page).to have_content('Task was successfully updated.')
    expect(page).to have_content('Go to yoga - Namaste')
    click_on 'Tasks'
    click_on "#{@task.description}"
    expect(page).to have_content("#{@task.description}")
    expect(page).to have_content("#{@task.date.to_formatted_s(:long)}")
    click_on 'Tasks'
    page.click_link('', :href => "/projects/#{@task.project_id}/tasks/#{@task.id}")
    expect(page).to have_content('Task was successfully destroyed.')
  end

end
