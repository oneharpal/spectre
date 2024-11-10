class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  broadcasts_to :commentable
end
