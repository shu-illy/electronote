# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  remember_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
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
