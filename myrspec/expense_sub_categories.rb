FactoryBot.define do
  factory :expense_sub_category do
    name { Faker::Name.name }
    category { create(:expense_category) }
    user_category { create(:user_category) }
  end
end