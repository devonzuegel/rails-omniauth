FactoryGirl.define do
  
  factory :user do
    name       "Test Middlename User"
    first_name "Test"
    last_name  "User"
    provider   "facebook"

    after :build do |user|
      user.account = FactoryGirl.create(:account)
    end

    trait :with_entries do
      after :create do |user|
        for x in 1..8
          FactoryGirl.create(:entry, user_id: user.id)
        end
      end
    end
  end

end
