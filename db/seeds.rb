User.create!(name: "Trần",
  email: "vansang10a6txqt@gmail.com",
  password: "vansang",
  password_confirmation: "vansang",
  confirmed_at: Time.zone.now)

5.times do |n|
  Event.create!(user_id: User.first.id,
    name: Faker::Appliance.brand,
    description: Faker::Restaurant.description,
    happen_at: Time.now
  )
end
