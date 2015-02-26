require 'rails_helper'

describe 'User can CRUD users' do

  before :each do

    User.create(email: 'aaron.rodgers@gbqb.com', password: 'touchdown', first_name: 'Aaron', last_name: 'Rodgers')
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'aaron.rodgers@gbqb.com'
    fill_in 'Password', :with => 'touchdown'
    click_button 'Login'
  end


  scenario 'Users can create a user' do

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
  end

  scenario 'Users can edit a user' do

    click_on 'Users'
    click_on 'Edit'
    fill_in 'First name', with: 'Basil'
    fill_in 'Last name', with: 'Oriegano'
    fill_in 'Email', with: 'spice@cabinet.kt'
    fill_in 'Password', with: 'mew'
    fill_in 'user[password_confirmation]', with: 'mew'
    click_button 'Update User'
    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content('Basil Oriegano')
  end

  scenario 'Users can show a user' do

    @user = User.create(first_name: 'Jon', last_name: 'Appleseed', email: 'jon@apple.com', password: 'secret', password_confirmation: 'secret')
    click_on 'Users'
    click_link 'Jon Appleseed'
    expect(page).to have_content('Jon Appleseed')
    expect(page).to have_content('jon@apple.com')
  end

  scenario 'Users can delete a user' do

    @user = User.create(first_name: 'Jon', last_name: 'Appleseed', email: 'jon@apple.com', password: 'secret', password_confirmation: 'secret')
    click_on 'Users'
    click_link 'Jon Appleseed'
    click_on 'Edit'
    click_on 'Delete'
    expect(page).to have_content('User was successfully destroyed.')
  end

end
