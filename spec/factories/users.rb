FactoryGirl.define do
  
  factory :user do
    transient do
      skip_confirmation true
    end

    name "Test User"
    email "user11@gmail.com"
    password "please123"
    
    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end

  factory :other_user, :parent => :user do
    transient do
      skip_confirmation true
    end

    name "Other User"
    email "other123@example.com"
    password "please123"
    
    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end

  factory :john, :parent => :user do
    name "John User"
    email "john@example.com"
    password "please123"
  end

  factory :robert, :parent => :user do
    name "Robert User"
    email "robert@example.com"
    password "please123"
  end

  factory :admin, :parent => :user do
    transient do
      skip_confirmation true
    end

    name "Admin User"
    email "admin@admin.com"
    password "please123"
    admin true

    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end    
  end

  factory :non_skip_user, :parent => :user do
    transient do
      skip_confirmation false
    end

    name "Nonskip User"
    email { Faker::Internet.email }
    password "password123"
    admin false

    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end

  factory :miroslav, :parent => :user do 
    transient do
      skip_confirmation true
    end

    name "Miroslav Gojic"
    email { Faker::Internet.email }
    password "123greetings"

    factory :user_with_posts do
      transient do
        microposts_count 50 
      end

      after(:create) do |user, evaluator|
        create_list(:micropost, evaluator.microposts_count, user: user)
      end
    end
    
    before(:create) do |user, evaluator|
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end

end