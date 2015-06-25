FactoryGirl.define do
  factory :account do
    theme Account.themes.first
    public_posts false

    # trait :with_user_attributes do
    #   info = {        
    #     first_name:  Faker::Name.first_name,
    #     middle_name: Faker::Name.first_name,
    #     last_name:   Faker::Name.last_name
    #   }
    #   user_attributes(info.merge({
    #     name: "#{info['first_name']} #{info['middle_name']} #{info['last_name']}" 
    #   }) )
    # end
  end

end
