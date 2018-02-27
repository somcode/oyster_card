class Oyestercard

  attr_reader :balance, :entry_station, :journey_history
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1



  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise " Maximum balance of #{MAXIMUM_BALANCE} exceeded " if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "you dont have enough credit" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey_history <<  { journey_start: @entry_station, journey_stop: station }
    @entry_station = nil
  end

  def in_journey?
    entry_station != nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
