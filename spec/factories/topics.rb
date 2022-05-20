FactoryBot.define do
  factory :topic do
    name {Faker::Name.first_name}
  end
end
