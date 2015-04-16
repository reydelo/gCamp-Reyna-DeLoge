require 'rails_helper'

describe 'User can CRUD users' do

  before :each do

    @user = User.create(email: 'yeezus@god.com', password: 'godeqlye', first_name: 'Kanye', last_name: 'West')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{@user.email}"
    fill_in 'Password', :with => "#{@user.password}"
    click_button 'Login'
    click_on 'Users'
  end

  scenario 'Users can create a user' do

    click_on 'New User'
    fill_in 'First name', with: 'Basil'
    fill_in 'Last name', with: 'Oriegano'
    fill_in 'Email', with: 'spice@cabinet.kt'
    fill_in 'Password', with: 'meow'
    fill_in 'user[password_confirmation]', with: 'meow'
    click_button 'Create User'
    expect(page).to have_content('User was successfully created.')
    expect(page).to have_content('Basil Oriegano')
  end

  scenario 'Users can edit a user' do

    click_on 'Edit'
    fill_in 'First name', with: 'Basil'
    fill_in 'Last name', with: 'Oriegano'
    fill_in 'Password', with: 'mew'
    fill_in 'user[password_confirmation]', with: 'mew'
    click_button 'Update User'
    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content('Basil Oriegano')
  end

  scenario 'Users can show a user' do

    within(:table) do
      click_on "#{@user.first_name} #{@user.last_name}"
    end
    expect(page).to have_content("#{@user.first_name} #{@user.last_name}")
  end

  scenario 'Users can delete a user' do

    within(:table) do
      click_on "#{@user.first_name} #{@user.last_name}"
    end
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content('You have successfully destroyed your account. Please register to gain access.')
  end

  scenario 'Admin user can CRUD projects' do

    click_on 'Logout'
    admin = User.create(email: 'admin@email.com', password: 'password', first_name: 'Admin', last_name: 'User', admin: true)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => "#{admin.email}"
    fill_in 'Password', :with => "#{admin.password}"
    click_button 'Login'
    click_on 'Users'
    click_on 'New User'
    fill_in 'First name', with: 'Basil'
    fill_in 'Last name', with: 'Oriegano'
    fill_in 'Email', with: 'spice@cabinet.kt'
    fill_in 'Password', with: 'meow'
    fill_in 'user[password_confirmation]', with: 'meow'
    click_button 'Create User'
    expect(page).to have_content('User was successfully created.')
    expect(page).to have_content('Basil Oriegano')
    click_on 'Users'
    visit "/users/#{@user.id}/edit"
    fill_in 'Password', with: 'mew'
    fill_in 'user[password_confirmation]', with: 'mew'
    click_button 'Update User'
    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content('Basil Oriegano')
    click_on 'Users'
    within(:table) do
      click_on "#{@user.first_name} #{@user.last_name}"
    end
    expect(page).to have_content("#{@user.first_name} #{@user.last_name}")
    visit '/users'
    within(:table) do
      click_on "#{@user.first_name} #{@user.last_name}"
    end
    visit "/users/#{@user.id}/edit"
    click_on 'Delete'
  end

end
