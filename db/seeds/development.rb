10.times { FactoryBot.create(:airfield) }
2.times { FactoryBot.create(:user,user_type: User.get_user_types[:admin])}
airfield_ids = Airfield.all.pluck(:id)
15.times {
  connected_airfields = airfield_ids.sample(2)
  connection = FactoryBot.create( :connection, airfield_a_id: connected_airfields[0], airfield_b_id: connected_airfields[1] )
}