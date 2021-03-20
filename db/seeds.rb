# frozen_string_literal: true

# メインのサンプルユーザーを1人作成する
User.create!(name: 'Example User',
             email: 'example@electronote.net',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@electronote.net"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

# ユーザーの一部を対象に作品投稿を生成する
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  description = Faker::Lorem.sentence(word_count: 10)
  users.each { |user| user.works.create!(title: title, description: description) }
end
