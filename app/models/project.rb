class Project < ApplicationRecord
  before_destroy :stop_destroy
  before_create :set_default_value

  private

  def stop_destroy
    if self.immortal?
      errors.add(:immortal, message: "can't be destroy")
      raise ActiveRecord::RecordNotDestroyed
    end
  end

  def set_default_value
    self.title = "Project #{calculate_sequence_number}" if title.blank?
    self.description = "Project description #{calculate_sequence_number}" if description.blank?
    self.immortal = true if immortal.nil?
  end

  def calculate_sequence_number
    Project.maximum(:id).to_i + 1
  end
end
