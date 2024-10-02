# spec/system/user_login_spec.rb
require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  let!(:user) { create(:user) }

  it 'allows a logged-in user to access the dashboard' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq(root_path)
  end
end
