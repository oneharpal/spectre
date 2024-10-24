class Note < ApplicationRecord
  has_paper_trail
  belongs_to :project
  delegate :title, to: :project, allow_nil: true, prefix: true
  validates :title, presence: true
end
