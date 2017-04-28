FactoryGirl.define do
  factory :reply do
    sequence :content do |n|
      "Content #{n}"
    end

    trait :with_post do
      post { create(:post, :with_user) }
    end

    trait :with_user do
      user { create(:user_sequence) }
    end
  end
end
