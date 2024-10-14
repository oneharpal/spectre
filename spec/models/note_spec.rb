require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:project) }
  end
end
