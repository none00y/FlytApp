10.times {FactoryBot.create (:airfield) }
airfield_ids = Airfield.all.pluck(:id)
15.times {
  connected_airfields = airfield_ids.sample(2)
  FactoryBot.create (:connection,connected_airfields[0],connected_airfields[1])
}