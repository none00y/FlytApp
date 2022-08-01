class AirplaneStatusUpdateJob < ApplicationJob
  # change depending on how frequently the task will be performed
  REFRESH_TIME = 1.minute
  @current_time = Time.now
  BOARDING_DELAY = 5.minutes

  def perform
    @current_time = Time.now
    board_airplanes
    start_boarding_airplanes
    unboard_airplanes
    move_airplanes
  end

  def unboard_airplanes
    unboarding_airplanes = Airplane.where(state: Airplane.states[:unboarding])

    unboarding_airplanes.each do |airplane|
      airplane.passengers.order('RANDOM()').limit(30).update_all(airplane_id: nil)
      if airplane.passengers.empty?
        airplane.update(state: Airplane.get_states[:awaiting],percentage_of_distance_travelled: 0, returning: !airplane.returning)
      end
      puts "Unboarding #{airplane.identifier}"
    end
  end

  def board_airplanes
    boarding_airplanes = Airplane.where(state: Airplane.states[:boarding])

    boarding_airplanes.each do |airplane|
      passengers = Passenger.where(airplane_id: nil).sample(rand(1..airplane.passenger_capacity / 4))

      unless passengers.size > airplane.passenger_capacity - airplane.passengers.size
        passengers.each do |passenger|
          passenger.update(airplane_id: airplane.id)
        end
      end
      puts "Boarding #{airplane.identifier} #{airplane.passengers.size}/#{airplane.passenger_capacity}, tried adding #{passengers.size}"
    end
    airplanes_to_lift_off = boarding_airplanes.where('(departure_time::time <= :start_time) AND (departure_day::integer = :day_of_week)',
                                                     day_of_week: @current_time.wday,
                                                     start_time: @current_time.strftime('%R'))

    airplanes_to_lift_off.update_all(state: Airplane.get_states[:flying])
  end

  def start_boarding_airplanes    
    start_time = @current_time + BOARDING_DELAY
    end_time = @current_time + BOARDING_DELAY + REFRESH_TIME
    if start_time.wday != end_time.wday
      airplanes_waiting_to_board = Airplane.where('(departure_day::integer = :day_of_week) AND ((departure_time::time >= :start_time) OR (departure_time::time < :end_time))',
      day_of_week: end_time.wday,
      start_time: start_time.strftime('%R%Z'),
      end_time: end_time.strftime('%R%Z'))
    else
      airplanes_waiting_to_board = Airplane.where('(departure_day::integer = :day_of_week) AND ((departure_time::time >= :start_time) AND (departure_time::time < :end_time))',
      day_of_week: start_time.wday,
      start_time: start_time.strftime('%R%Z'),
      end_time: end_time.strftime('%R%Z'))
    end
    puts (@current_time + BOARDING_DELAY).strftime('%R%Z')
    puts (@current_time + BOARDING_DELAY + REFRESH_TIME).strftime('%R%Z')

    airplanes_waiting_to_board.each do |airplane|
      airplane.update(state: Airplane.get_states[:boarding])
      puts "Start boarding #{airplane.identifier}"
    end
  end

  def move_airplanes
    flying_airplanes = Airplane.where(state: Airplane.get_states[:flying])

    flying_airplanes.each do |airplane|
      airplane.percentage_of_distance_travelled += airplane.flight_speed * REFRESH_TIME / 1.hour / airplane.connection.distance * 100
      if airplane.percentage_of_distance_travelled > 100
        airplane.state = Airplane.get_states[:unboarding]
        airplane.percentage_of_distance_travelled = 0
      end
      airplane.save
      puts "Moving #{airplane.identifier}"
    end
  end
end
