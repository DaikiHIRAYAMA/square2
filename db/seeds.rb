# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 #<User id: 2, email: "user2@sample.com", created_at: "2022-06-21 10:15:35", updated_at: "2022-06-21 10:16:10", name: "user2">,


5.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "貸し借り太郎#{n + 1}",
      password: "password",
      #password_confirmation: "password",
      confirmed_at: Time.now,
    )
  end