class Work < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  scope :category, -> (category) { where category: category }
end
