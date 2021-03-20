# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'test@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end

  factory :second_user, class: User do
    name { 'Test User2' }
    email { 'test2@test.co.jp' }
    password { 'test2test' }
    password_confirmation { 'test2test' }
  end

  factory :third_user, class: User do
    name { 'Test User3' }
    email { 'test3@test.co.jp' }
    password { 'test3test' }
    password_confirmation { 'test3test' }
  end

  factory :admin_user, class: User do
    name { 'Admin User' }
    email { 'admin@test.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
    admin { true }
  end
end
