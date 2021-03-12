class Work < ApplicationRecord
  belongs_to :user
  has_one_attached :diagram
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :diagram, presence: true, 
                      content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "ファイル形式が正しくありません" },
                      size:   { less_than: 5.megabytes,
                                message: "5MB以上の画像はアップロードできません" }

  def display_diagram
    diagram.variant(resize_to_limit: [500, 500])
  end
end
