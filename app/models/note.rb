class Note < ApplicationRecord
  include Immortality
  has_paper_trail
  enum status: [ "draft", "in_progress", "review", "completed", "archived", "published", "canceled", "important" ]

  belongs_to :project
  has_many :comments, as: :commentable
  delegate :title, to: :project, allow_nil: true, prefix: true
  validates :title, presence: true

  after_initialize :set_default_values, if: :new_record?
  before_save :check_rank

  scope :by_rank, -> { order(rank: :asc) }

  broadcasts_to :project

  private
  def set_default_values
    self.immortal ||= true
    self.status ||= "draft"
    self.rank ||= project.notes.maximum(:rank) + 1 rescue 0
    self.body = title if body.blank?
  end

  def check_rank
    return if new_record?
    return if !rank_changed?
    return if self.rank.nil? || self.rank == 0
    return unless n = self.project.notes.find_by(rank: self.rank)
    rearrange_ranks
  end

  def rearrange_ranks
    rank < rank_was ? increment_rank : decrement_rank
  end

  def increment_rank
    new_rank = rank
    project.notes.where(rank: rank..rank_was).where.not(id: id).order(rank: :asc).each do |rc|
      break if new_rank != rc.rank
      new_rank = rc.rank + 1
      rc.update_columns(rank: new_rank)
    end
  end

  def decrement_rank
    new_rank = rank
    project.notes.where(rank: rank_was..rank).where.not(id: id).order(rank: :desc).each do |rc|
      break if new_rank != rc.rank
      new_rank = rc.rank - 1
      rc.update_columns(rank: new_rank)
    end
  end
end
