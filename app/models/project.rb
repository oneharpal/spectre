class Project < ApplicationRecord
  has_paper_trail

  include Immortality
  before_create :set_default_value
  has_many :notes

  validates :title, presence: true

  private

  def set_default_value
    self.title = "Project #{calculate_sequence_number}" if title.blank?
    self.description = "Project description #{calculate_sequence_number}" if description.blank?
    self.immortal = true if immortal.nil?
  end

  def calculate_sequence_number
    Project.maximum(:id).to_i + 1
  end
end
