FactoryGirl.define do

	factory :micropost do
    content 		"Lorem Ipsum"
    created_at  { Time.now}
    user
  end
  
  factory :other_user_post, :parent => :micropost do
    content    "This is the best"
    created_at  { 3.years.ago}
  end

  factory :orange, :parent => :micropost do
    content    "It's a simply orange"
    created_at  { Time.now - 10.minutes}
  end

  factory :cat_video, :parent => :micropost do
    content    "I just saw a cat"
    created_at  { 2.hours.ago}
  end

  factory :most_recent, :parent => :micropost do
    content    "This is my most recent post"
    created_at  { Time.zone.now}
  end

end
