FactoryBot.define do
  factory :airfield do
    name { Faker::Address.city } 
    longitude { rand -180..180 }
    latitude { rand -90..90 }
    airfield_plane_capacity { rand 0..50}
  end
end
