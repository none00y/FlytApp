FactoryBot.define do
  factory :connection do  
    airfield_a_id { :airfield_a_id }
    airfield_b_id { :airfield_b_id }
    distance { calculate_distance_between_airfields }
  end
end
