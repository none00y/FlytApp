FactoryBot.define do
  sequence(:email) { |n| "latwe#{n}@wp.pl"}
  factory :user do
    user_type {:basic_user}
    email {generate(:email)}
    password {"123457"}
    trait :admin do 
      user_type {:admin}
    end

  end
end
