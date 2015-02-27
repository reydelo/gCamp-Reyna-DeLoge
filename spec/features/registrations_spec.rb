require 'rails_helper'
describe 'User can CRUD users' do

  scenario 'Users can sign up' do

    click_on 'Register'
    fill_in 'First name', with: 'Marky'
    click_on 'Sign Up'
    expect(page).to have_content(')

  end

end
