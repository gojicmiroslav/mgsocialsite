FactoryGirl.define do

	factory :relationship do
    association :follower, factory: :miroslav
		association :followed, factory: :admin 
  end
  
  factory :relationship1, parent: :relationship do
    association :follower, factory: :user
		association :followed, factory: :miroslav 
  end

  factory :relationship2, parent: :relationship do
    association :follower, factory: :miroslav
		association :followed, factory: :other_user 
  end

  factory :relationship3, parent: :relationship do
    association :follower, factory: :john
		association :followed, factory: :miroslav 
  end

  factory :relationship4, parent: :relationship do
    association :follower, factory: :robert
		association :followed, factory: :miroslav 
  end

end
