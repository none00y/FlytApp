FactoryBot.define do
  factory :airplane do
    identifier { Faker::Base.regexify(/[A-Z0-9]{1,3}-[A-Z]{3}/) }
    percentage_of_distance_travelled { 0.0 }
    passenger_capacity { rand(1..200) }
    flight_speed { rand(700..950) }

    departure_day { Airplane.get_departure_days.keys.sample }
    departure_time { Faker::Time.between(from: Time.now + 60 * 10, to: Time.now + 3600 * 2).seconds_since_midnight / 60 }

    state { :awaiting }

    trait :boarding do
      state { :boarding }
    end
    trait :moving_to_destination do
      state { :moving_to_destination }
    end

    connection { :connection }
  end
end
