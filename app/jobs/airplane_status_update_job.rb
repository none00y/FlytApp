class AirplaneStatusUpdateJob < ApplicationJob
  # change depending on how frequently the task will be performed
  REFRESH_TIME = 1.minute.freeze
  CURRENT_TIME = Time.now.utc.freeze
  BOARDING_DELAY = 5.minutes.freeze  

  def perform
    start_boarding_airplanes
    board_airplanes
    unboard_airplanes
    move_airplanes
  end

  def unboard_airplanes
    unboarding_airplanes = Airplane.where(state: Airplane.states[:unboarding])

    unboarding_airplanes.each do |airplane|
      airplane.passengers.order("RANDOM()").limit(30).update_all(airplane_id: nil)
      if airplane.passengers.size == 0 
        airplane.update(state: Airplane.get_states[:awaiting])
      end
      puts "Unboarding #{airplane.identifier}"
    end
  end

  def board_airplanes 
    boarding_airplanes = Airplane.where(state: Airplane.states[:boarding])

    boarding_airplanes.each do |airplane|
      passengers = Passenger.where(airplane_id: nil).sample(rand(1..airplane.passenger_capacity/4))

      unless passengers.size > airplane.passenger_capacity - airplane.passengers.size
        passengers.each do |passenger|
          passenger.update(airplane_id: airplane.id)
        end
      end
      puts "Boarding #{airplane.identifier} #{airplane.passengers.size}/#{airplane.passenger_capacity}, try adding #{passengers.size}"
    end

    airplanes_to_lift_off = boarding_airplanes.where("(departure_time::time >= :start_time) AND (departure_time::time < :end_time)",
    start_time: (CURRENT_TIME).strftime("%r"),
    end_time:   (CURRENT_TIME + REFRESH_TIME).strftime("%r")
    )

    airplanes_to_lift_off.update_all(state: Airplane.get_states[:flying])
  end

  def start_boarding_airplanes
    airplanes_waiting_to_board = Airplane.where("(departure_day::integer = :day_of_week) AND (departure_time::time >= :start_time) AND (departure_time::time < :end_time)",
    day_of_week: (CURRENT_TIME + BOARDING_DELAY).wday,
    start_time: (CURRENT_TIME + BOARDING_DELAY).strftime("%r"),
    end_time:   (CURRENT_TIME + BOARDING_DELAY + REFRESH_TIME).strftime("%r")
    )

    airplanes_waiting_to_board.each do |airplane|
      if airplane.state != Airplane.get_states[:awaiting]
        puts "STATE ERROR in Airplane #{airplane.id}: is: #{airplane.state} should be: #{Airplane.get_states[:boarding]}"
      end
      airplane.update(state: Airplane.get_states[:boarding])
      puts "Strat boarding #{airplane.identifier}"
    end
  end
  
  def move_airplanes
    flying_airplanes = Airplane.where(state: Airplane.get_states[:flying])

    flying_airplanes.each do |airplane|
      airplane.percentage_of_distance_travelled += airplane.flight_speed*REFRESH_TIME/1.hour/airplane.connection.distance * 100
      if airplane.percentage_of_distance_travelled > 100
        airplane.state = Airplane.get_states[:unboarding]
        airplane.percentage_of_distance_travelled = 0
      end
      airplane.save
      puts "Moving #{airplane.identifier}"
    end
  end
end