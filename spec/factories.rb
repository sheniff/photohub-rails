FactoryGirl.define do
  factory :user do
    sequence(:name)         { |n| "Person #{n}"}
    sequence(:email)        { |n| "person_#{n}@example.com"}
    password                "123456"
    password_confirmation   "123456"

    factory :admin do
      admin true
    end
  end

  factory :album do
    sequence(:title)         { |n| "Example Album"}
    sequence(:description)   { |n| "Lorem ipsum dolor sit amet"}
    user
  end
end
