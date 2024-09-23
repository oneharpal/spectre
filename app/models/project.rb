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
    self.immortal = true
  end

  def calculate_sequence_number
    @sequence_number||=Project.last&.id.to_i+1
  end
end
