User.create!(first_name: "Trần",
  last_name: "Van Sang",
  email: "vansang10a6txqt@gmail.com",
  password: "vansang",
  password_confirmation: "vansang",
  confirmed_at: Time.zone.now,
  role: 1)
10.times do |n|
  User.create!(first_name: Faker::Appliance.brand,
    last_name: Faker::Appliance.brand,
    email: "user_#{n}@s-event.com",
    password: "vansang",
    password_confirmation: "vansang",
    confirmed_at: Time.zone.now,
    role: 0)
end

Topic.create!(name: "Wedding")
