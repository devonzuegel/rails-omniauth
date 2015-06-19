FactoryGirl.define do
  factory :account do
    theme Account.themes.first
    public_posts false
  end

end
