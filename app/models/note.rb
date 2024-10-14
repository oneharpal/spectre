class Note < ApplicationRecord
  belongs_to :project
  delegate :title, to: :project, allow_nil: true, prefix: true
  validates :title, presence: true
end
