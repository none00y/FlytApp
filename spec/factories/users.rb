FactoryBot.define do
  sequence(:email) { |n| "latwe#{n}@wp.pl"}
  factory :user do
    email {generate(:email)}
    password {"123457"}
    user_type {:basic_user}
    trait :admin do 
      user_type {:admin}
    end

  end
end
