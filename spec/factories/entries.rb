FactoryGirl.define do
  factory :entry do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph }
  end
end
