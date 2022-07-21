10.times { FactoryBot.create(:airfield) }

2.times { FactoryBot.create(:user,user_type: User.get_user_types[:admin])}

airfield_ids = Airfield.all.pluck(:id)

airfield_ids.each { |i|
  airfield_ids.reject { |id| id == i }.sample
  connection = FactoryBot.create( :connection, airfield_a_id: i, 
  airfield_b_id: airfield_ids.reject { |id| id == i }.sample )
}
50.times { FactoryBot.create(:airplane, connection: Connection.all.sample) }