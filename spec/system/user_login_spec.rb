# spec/system/user_login_spec.rb
require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  let!(:user) { User.create!(email: 'testuser@example.com', password: 'password123') }

  it 'allows a logged-in user to access the dashboard' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq(root_path)
  end

end
