FactoryBot.define do
  factory :passenger do
    state { :free }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
