class Note < ApplicationRecord
  belongs_to :project, optional: true
  delegate :title, to: :project, allow_nil: true, prefix: true
end
