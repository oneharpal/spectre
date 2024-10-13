module Immortality
  extend ActiveSupport::Concern

  included do
    before_destroy :stop_destroy
  end

  def stop_destroy
    if self.immortal?
      errors.add(:immortal, message: "can't be destroyed")
      raise ActiveRecord::RecordNotDestroyed
    end
  end
end
