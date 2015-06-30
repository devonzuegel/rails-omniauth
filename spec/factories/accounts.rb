# encoding: utf-8
FactoryGirl.define do
  factory :account do
    theme Account.themes.first
    public_posts false

    trait :with_public_posts do
      public_posts true
    end
  end
end
