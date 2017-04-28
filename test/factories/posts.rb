FactoryGirl.define do
  factory :post do
    sequence :content do |n|
      "Content #{n}"
    end
    trait :with_user do
      user { create(:user_sequence) }
    end

    trait :with_replies do
      transient do
        reply_number 3
      end
      after :create do |post, evaluator|
        evaluator.reply_number.times do
          post.replies.create!(attributes_for(:reply, :with_user))
        end
      end
    end
  end
end