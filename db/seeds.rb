User.create!(first_name: "Trần",
  email: "vansang10a6txqt@gmail.com",
  password: "vansang",
  password_confirmation: "vansang",
  confirmed_at: Time.zone.now,
  role: 1)
Topic.create!(name: "Wedding")
Topic.create!(name: "Wedding 12")
Event.create!(
  user_id: User.first.id,
  name: "Root",
  description: "Faker::Restaurant.description",
  happen_at: Time.now
)
Task.create!(name: "Di choi", event: Event.first)
topic = Topic.first
topic.tasks  << Task.first
topic.save!

5.times do |n|
  Event.create!(
    user_id: User.first.id,
    name: Faker::Appliance.brand,
    description: "Faker::Restaurant.description",
    happen_at: Time.now,
    topic: Topic.first
  )
end
