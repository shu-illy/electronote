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
FactoryBot.define do
  factory :work do
    title { 'Title of Work' }
    description { 'Test description' }
    circuit {
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/picture/test_circuit.png'), 'image/png')
    }
    # circuit { File.new("#{Rails.root}/spec/factories/picture/test_circuit.png") }
    association :user

    trait :yesterday do
      title { 'title_yesterday' }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      title { 'title_day_before_yesterday' }
      created_at { 2.day.ago }
    end

    trait :now do
      title { 'title_now' }
      created_at { Time.zone.now }
    end

    trait :mine do
      title { 'これは私の投稿です' }
      created_at { 3.minutes.ago }
    end
  end

  factory :work_by_second do
    title { '作品のタイトル' }
    description { '説明文' }
    association :second_user
  end
end
