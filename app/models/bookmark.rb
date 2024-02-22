class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :comment, length: { minimum: 6 }
  validates :movie_id, :list_id, presence:true
  validates :list_id, uniqueness: { scope: :movie_id }
  validates :comment, presence:true
end
