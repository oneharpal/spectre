class Note < ApplicationRecord
  include Immortality
  has_paper_trail
  enum status: ["draft", "in_progress", "review", "completed", "archived", "published", "canceled", "important"]

  belongs_to :project
  delegate :title, to: :project, allow_nil: true, prefix: true
  validates :title, presence: true

  after_initialize :set_default_values, if: :new_record?

  scope :by_rank, -> { order(rank: :asc) }

  broadcasts_to :project

  private
  def set_default_values
    self.immortal ||= true
    self.status ||= "draft"
    self.rank ||= 0
  end
end
