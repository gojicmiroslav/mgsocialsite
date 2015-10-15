FactoryGirl.define do
  
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please123"
  end

  factory :other_user, :parent => :user do
    name "Another User"
    email "another@example.com"
    password "please123"
  end

  factory :michael, :parent => :user do
    name "michael Example"
    email "michael123@example.com"
    password "please123"
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
    name "Admin User"
    email "admin@admin.com"
    password "please123"
    admin true
  end

end