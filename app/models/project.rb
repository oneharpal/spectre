class Project < ApplicationRecord
  has_paper_trail

  include Immortality
  before_create :set_default_value
  has_many :notes
  belongs_to :parent_project, class_name: 'Project', optional: true
  has_many :sub_projects, class_name: 'Project', foreign_key: 'parent_project_id'

  validates :title, presence: true

  def parent_candidates
    self.class.where.not(id: [id] + all_descendants.map(&:id))
  end

  def all_descendants
    sub_projects + sub_projects.flat_map(&:all_descendants)
  end

  private

  def set_default_value
    self.title = "Project #{calculate_sequence_number}" if title.blank?
    self.description = "Project description #{calculate_sequence_number}" if description.blank?
    self.immortal = true if immortal.nil?
  end

  def calculate_sequence_number
    Project.maximum(:id).to_i + 1
  end
end
