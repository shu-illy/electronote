# frozen_string_literal: true

class Work < ApplicationRecord
  belongs_to :user
  mount_uploader :circuit, CircuitUploader
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validate :circuit_filesize

  private

  def circuit_filesize
    return unless circuit.size > 5.megabytes

    errors.add(:circuit, '5MB以下のファイルをアップロードしてください')
  end
end
