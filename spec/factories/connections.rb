FactoryBot.define do
  factory :connection do
    airfield_a {:airfield_a}
    airfield_b {:airfield_b}
    distance {get_distance_between_airfields}
  end
end
