2.times { FactoryBot.create(:user, user_type: User.get_user_types[:admin]) }
10.times { FactoryBot.create(:airfield) }

airfield_ids = Airfield.all.pluck(:id)

airfield_ids.each do |i|
  other_airfields = airfield_ids.reject { |id| id == i }.sample(3)
  other_airfields.each do |other_airfield|
    FactoryBot.create(:connection, airfield_a_id: i, airfield_b_id: other_airfield)
  end
end
50.times { FactoryBot.create(:airplane, connection: Connection.all.sample) }
5000.times { FactoryBot.create(:passenger) }
