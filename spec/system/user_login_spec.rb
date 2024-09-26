# spec/system/user_login_spec.rb
require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  let!(:user) { User.create!(email: 'testuser@example.com', password: 'password123') }

  before do
    login_as(user)  # Use the helper to log in the user
  end

  it 'allows a logged-in user to access the dashboard' do
    visit dashboard_path
    expect(page).to have_content('Welcome to your dashboard')
    expect(current_path).to eq(dashboard_path)
  end

  it 'does not allow access to the dashboard for logged-out users' do
    click_link 'Logout' # Assuming your app has a logout link
    visit dashboard_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
