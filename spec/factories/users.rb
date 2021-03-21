# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'test@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end

  factory :second_user, parent: :user do
    name { 'Test User2' }
    email { 'test2@test.co.jp' }
  end

  factory :third_user, parent: :user do
    name { 'Test User3' }
    email { 'test3@test.co.jp' }
  end

  factory :admin_user, parent: :user do
    name { 'Admin User' }
    email { 'admin@test.com' }
    admin { true }
  end

  factory :follower, parent: :user do
    name { 'Follower' }
    email { 'follower@test.co.jp' }
  end

  factory :followed, parent: :user do
    name { 'Followed' }
    email { 'follwed@test.co.jp' }
  end
end
