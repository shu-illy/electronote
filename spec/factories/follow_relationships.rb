# frozen_string_literal: true

FactoryBot.define do
  factory :follow_relationship do
    association :follower
    association :followed
    follower_id { follower.id }
    followed_id { followed.id }
  end
end
