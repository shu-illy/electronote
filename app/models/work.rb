# frozen_string_literal: true

# == Schema Information
#
# Table name: works
#
#  id          :bigint           not null, primary key
#  circuit     :string(255)
#  description :text(65535)
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_works_on_user_id                 (user_id)
#  index_works_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
