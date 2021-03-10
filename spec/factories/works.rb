FactoryBot.define do
  factory :work do
    title { "作品のタイトル" }
    description { "説明文" }
    association :user

    trait :yesterday do
      title { "title_yesterday"}
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      title { "title_day_before_yesterday"}
      created_at { 2.day.ago }
    end

    trait :now do
      title { "title_now"}
      created_at { Time.zone.now }
    end

    trait :mine do
      title { "これは私の投稿です" }
      created_at { 3.minutes.ago }
    end

  end

  factory :work_by_second do
    title { "作品のタイトル" }
    description { "説明文" }
    association :second_user
  end
end
