class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end

class Train
  attr_reader :number, :type, :wagon_count, :speed

  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @station_index = 0
  end

  def speed_up
    @speed += 20
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagon_count += 1 if @speed.zero?
  end

  def delete_wagon
    @wagon_count -= 1 if @speed.zero? && @wagon_count > 0
  end

  def route=(route)
    @route = route
    @station_index = 0
    current_station.take_train(self)
  end

  def go_forward
    if @route.stations[@station_index] != @route.stations[-1]
      current_station.send_train(self)
      @station_index += 1
      current_station.take_train(self)
    else
      puts "It's last station"
    end  
end
  
  def go_backward
    if @route.stations[@station_index] != @route.stations[0]
      current_station.send_train(self)
      @station_index -= 1
      current_station.take_train(self)
    else
      puts "It's first station"
    end 
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    if @route.stations[@station_index] != @route.stations[-1]
      @route.stations[@station_index + 1] 
    else
      puts "It's last station"
    end  
  end
  
  def previous_station
    if @route.stations[@station_index] != @route.stations[0]
      @route.stations[@station_index - 1]
    else
      puts "It's first station"
    end
end
