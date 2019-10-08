class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2
  attr_reader :balance
  attr_reader :max_balance
  attr_reader :min_balance
  attr_reader :min_fare
  attr_reader :entry_station

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
    @min_balance = MIN_BALANCE
    @min_fare = MIN_FARE
    @entry_station
  end

  def top_up(deposit)
    fail 'Max balance reached' if full?(deposit)
    @balance += deposit
  end

  def full?(deposit)
    (@balance + deposit) > max_balance
  end

  def touch_in(station)
    get_station(station)
    fail 'Not enough funds' if (@balance < min_balance)
  end

  def touch_out
    deduct(min_fare)
    @entry_station = nil
  end

  def in_journey?
    entry_station != nil
  end

  def get_station(station)
    @entry_station = station
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end

class Station

end
