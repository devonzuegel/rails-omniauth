FactoryGirl.define do
  
  factory :user do
    first_name  Faker::Name.first_name
    middle_name Faker::Name.first_name
    last_name   Faker::Name.last_name
    provider   "facebook"

    after :build do |user|
      user.name    = "#{user.first_name} #{user.middle_name} #{user.last_name}"
      user.account = FactoryGirl.create(:account)
    end


    ## Traits ##

    trait :with_entry do
      after :create do |user|
        FactoryGirl.create(:entry, user_id: user.id)
      end
    end

    trait :with_5_entries do
      after :create do |user|
        for i in 1..5
          FactoryGirl.create(:entry, user_id: user.id)
        end
      end
    end
  end

end
