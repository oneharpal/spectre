require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  # Validation test
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without valid email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid for duplicate email' do
    create(:user, email: user.email)
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include('has already been taken')
  end

  context 'destroy action' do
    let!(:user) { create(:user, immortal: true) }

    it 'can not destroy immortal user' do
      expect { user.destroy }.to_not change { User.count }
      expect(user.errors[:immortal]).to include("can't be destroyed")
    end

    it 'can destroy non immortal user' do
      user.update(immortal: false)
      expect { user.destroy }.to change { User.count }.by(-1)
    end
  end
end
