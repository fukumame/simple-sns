FactoryGirl.define do
  factory :user do
    email 'ruby@example.com'
    password 'zaq12wsx'
    nickname 'Ruby Lover'
  end

  factory :user_sequence, class: User do
    sequence :email do |n|
      "ruby#{n}@example.com"
    end
    sequence :nickname do |n|
      "Ruby Lover#{n}"
    end
    password 'zaq12wsx'
  end

  trait :with_posts do
    transient do
      post_number 3
    end
    after(:create) do |user, evaluator|
      evaluator.post_number.times do
        user.posts.create!(attributes_for(:post, :with_user))
      end
    end
  end

  trait :with_posts_and_replies do
    transient do
      post_number 3
      reply_number 3
    end
    after(:create) do |user, evaluator|
      evaluator.post_number.times do
        p = user.posts.build(attributes_for(:post, :with_user))
        p.save!
        evaluator.reply_number.times do
          p.replies.create!(attributes_for(:reply, :with_user))
        end
      end
    end
  end
end