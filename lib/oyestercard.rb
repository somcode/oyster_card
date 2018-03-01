class Oyestercard

  attr_reader :balance, :journey_status
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1


  def initialize
    @balance = 0
    @journey_status = :not_in_transit
  end

  def top_up(amount)
    raise " Maximum balance of #{MAXIMUM_BALANCE} exceeded " if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "you dont have enough credit" if @balance < MINIMUM_FARE
    @journey_status = :in_transit
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @journey_status = :not_in_transit
  end

  def in_journey?
    journey_status == :in_transit
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
