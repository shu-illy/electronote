class Work < ApplicationRecord
  belongs_to :user
  has_one_attached :diagram
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end
