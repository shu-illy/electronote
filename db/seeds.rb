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
  circuit = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/picture/test_circuit.png'), 'image/png')
  users.each { |user| user.works.create!(title: title, description: description, circuit: circuit) }
end

# リレーションシップ作成
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
