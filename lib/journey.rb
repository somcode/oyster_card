class Journey
#starting journey, finishing journey, calculating fare
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6


  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def set_exit_station(exit_station)
    @exit_station = exit_station
  end

  def journey_complete?
    entry_station != nil && exit_station != nil
  end

  def fare
    journey_complete? ? MINIMUM_FARE : MAXIMUM_FARE
  end

end
