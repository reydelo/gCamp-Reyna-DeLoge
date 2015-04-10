require 'rails_helper'
describe 'User can CRUD registrations/signup' do

  before :each do

    @user = User.create(first_name: 'Reyna', last_name: 'DeLoge', email: 'reyna.deloge@gmail.com', password: 'meow')
  end

  scenario 'User can sign up' do

    visit '/signup'
    fill_in 'First name', with: 'Marky'
    fill_in 'Last name', with: 'Mark'
    fill_in 'Email', with: 'marky@mark.com'
    fill_in 'Password', with: 'meow'
    fill_in 'user[password_confirmation]', with: 'meow'
    click_on 'Sign Up'
    expect(page.current_path).to eq new_project_path
    expect(page).to have_content('Welcome! You have successfully signed up')

  end

  scenario 'User cannot sign up without a unique email' do

    visit '/signup'
    fill_in 'First name', with: 'Rey'
    fill_in 'Last name', with: 'DeLo'
    fill_in 'Email', with: "#{@user.email}"
    fill_in 'Password', with: 'meow'
    fill_in 'user[password_confirmation]', with: 'meow'
    click_on 'Sign Up'
    expect(page.current_path).to eq signup_path
    expect(page).to have_content('Email has already been taken')

  end

  scenario 'User cannot sign up without a secure password' do

    visit '/signup'
    fill_in 'First name', with: 'R'
    fill_in 'Last name', with: 'D'
    fill_in 'Email', with: 'rd@gmail.com'
    fill_in 'Password', with: 'mew'
    fill_in 'user[password_confirmation]', with: 'meow'
    click_on 'Sign Up'
    expect(page.current_path).to eq signup_path
    expect(page).to have_content("Password confirmation doesn\'t match Password")

  end

  scenario 'User can sign in' do

    visit '/login'
    fill_in 'Email', with: "#{@user.email}"
    fill_in 'Password', with: "#{@user.password}"
    click_button 'Login'
    expect(page.current_path).to eq projects_path
    expect(page).to have_content("Welcome back")

  end

  scenario 'User cannot sign in with invalid password/email' do

    visit '/login'
    fill_in 'Email', with: "#{@user.email}"
    fill_in 'Password', with: 'mew'
    click_button 'Login'
    expect(page.current_path).to eq login_path
    expect(page).to have_content("Username or password is incorrect")

  end

  scenario 'User can view their show page' do

    visit '/login'
    fill_in 'Email', with: "#{@user.email}"
    fill_in 'Password', with: "#{@user.password}"
    click_button 'Login'
    click_link 'Reyna DeLoge'
    expect(page).to have_content("Reyna DeLoge")
    expect(page).to have_content("reyna.deloge@gmail.com")

  end

  scenario 'User can sign out successfully' do

    visit '/login'
    fill_in 'Email', with: "#{@user.email}"
    fill_in 'Password', with: "#{@user.password}"
    click_button 'Login'
    expect(page.current_path).to eq projects_path
    expect(page).to have_content("Welcome back")
    click_on 'Logout'
    expect(page.current_path).to eq root_path
    expect(page).to have_content("You have successfully logged out")

  end

end
