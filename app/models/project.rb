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
    self.title = "Project #{Project.last.id+1}" if title.blank?
    self.description = "Project description #{Project.last.id+1}" if description.blank?
    self.immortal = true
  end
end
