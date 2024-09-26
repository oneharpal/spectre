# spec/system/user_logout_spec.rb
require 'rails_helper'

RSpec.describe 'User Logout', type: :system do
  let!(:user) { User.create(email: 'testuser@example.com', password: 'password123') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'allows a logged-in user to log out' do
    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end
