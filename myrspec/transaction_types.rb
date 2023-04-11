FactoryBot.define do
  factory :transaction_type do
    name { Faker::Name.name }
  end
end