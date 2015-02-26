require 'rails_helper'


describe 'User can CRUD tasks' do


  before :each do

    User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'aaron.rodgers@gbqb.com'
    fill_in 'Password', :with => 'touchdown'
    click_button 'Login'
  end


  scenario 'Users can create a task' do

    click_on 'Tasks'
    click_on 'New Task'
    fill_in 'Description', with: 'Get your shit done!'
    click_button 'Create Task'
    expect(page).to have_content('Task was successfully created.')
    expect(page).to have_content('Get your shit done!')
  end



  scenario 'Users can edit a task' do

    @task = Task.create(description: 'Go to yoga', date: '2015/03/17')
    visit '/tasks'
    click_on 'Edit'
    fill_in 'Description', with: 'Go to yoga - Namaste'
    click_button 'Update Task'
    expect(page).to have_content('Task was successfully updated.')
    expect(page).to have_content('Go to yoga - Namaste')
  end




  scenario 'Users can show a task' do

    @task = Task.create(description: 'Throw a bday party', date: '2015-05-25')
    visit '/tasks'
    click_link 'Throw a bday party'
    expect(page).to have_content('Throw a bday party')
    expect(page).to have_content('2015/05/25')

  end


  scenario 'Users can delete a task' do

    @task = Task.create(description: 'Watch corey open presents', date: '2015-05-13')
    visit '/tasks'
    click_on 'Delete'
    expect(page).to have_content('Task was successfully destroyed.')

  end

end
