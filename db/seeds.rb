# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
genre_names = %w(
  上半身
  下半身
  全身
)

genre_names.each { |name| Genre.create!(name: name) }

require 'faker'

10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
  user.save(validate: false)
end

10.times do
  Post.create(
    title: Faker::Lorem.sentence(word_count: 3),
    body: Faker::Lorem.paragraph(sentence_count: 4),
    user_id: rand(1..10)
  )
end

Admin.create!(
  email: 'admin@example.com',
  password: 'password'
)