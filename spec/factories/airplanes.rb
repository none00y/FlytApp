FactoryBot.define do
  factory :airplane do
    identifier { Faker::Base.regexify(/[A-Z0-9]{1,3}-[A-Z]{3}/) }
    percentage_of_distance_travelled { 0.0 }
    passenger_capacity { rand(70..200) }
    flight_speed { rand(700..950) }
    returning { false }
    # departure_day { Airplane.get_departure_days.keys.sample }
    departure_day { Airplane.get_departure_days.keys.sample }
    departure_time { Faker::Time.between(from: Time.now.utc + 6.minutes, to: Time.now.utc + 1.hour) }

    state { :awaiting }

    trait :boarding do
      state { :boarding }
    end
    trait :unboarding do
      state { :unboarding }
    end
    trait :flying do
      state { :flying }
    end

    connection { :connection }
  end
end
