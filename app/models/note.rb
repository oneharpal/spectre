class Note < ApplicationRecord
  has_paper_trail
  include Immortality
  belongs_to :project
  delegate :title, to: :project, allow_nil: true, prefix: true
  validates :title, presence: true

  before_create :set_default_value

  private
  def set_default_value
    self.immortal = true if self.immortal.nil?
  end
end
