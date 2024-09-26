# spec/system/invalid_login_spec.rb
require 'rails_helper'

RSpec.describe 'Invalid Login', type: :system do
  before do
    visit new_user_session_path
  end

  it 'shows an error with invalid credentials' do
    fill_in 'Email', with: 'wronguser@example.com'
    fill_in 'Password', with: 'wrongpassword'
    
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
