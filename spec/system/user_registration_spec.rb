# spec/system/user_registration_spec.rb
require 'rails_helper'

RSpec.describe 'User Registration', type: :system do
  before do
    visit new_user_registration_path
  end

  it 'allows a user to sign up' do
    fill_in 'Email', with: 'testuser@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
