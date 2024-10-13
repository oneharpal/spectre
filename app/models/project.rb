class Project < ApplicationRecord
  include Immortality
  before_create :set_default_value
  has_many :notes

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
