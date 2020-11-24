# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#メインサンプルユーザー
User.create!(
  name: "Example User",
  email: "example_main@example.com",
  password: "password",
  password_confirmation: "password"
)

#他のサンプルユーザを99人追加
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
  )
end

# ユーザーの一部を対象にフィルムを生成する
users = User.order(:created_at).take(6)
50.times do
  name = Faker::Lorem.sentence(word_count: 2)
  company = Faker::Lorem.sentence(word_count: 2)
  iso = "100"
  users.each { |user| user.films.create!(
    name: name, company: company, iso: iso) }
end