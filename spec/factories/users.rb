FactoryGirl.define do
  
  factory :user do
    name "Test Middlename User"
    first_name "Test"
    last_name "User"
    provider "facebook"
  end

end
