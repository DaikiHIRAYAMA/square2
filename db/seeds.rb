
5.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "貸し借り太郎#{n + 1}",
      password: "password",
      #password_confirmation: "password",
      confirmed_at: Time.now,
    )
  end