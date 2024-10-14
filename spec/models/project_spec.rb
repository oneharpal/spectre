require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should have_many(:notes) }
  end

  describe 'immortal' do
    it 'set true for new project if it is nil' do
      project = Project.new(title: 'Test project title', description: 'Test description')
      project.save
      expect(project.immortal).to be(true)
    end
  end
end
