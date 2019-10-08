class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2
  attr_reader :balance
  attr_reader :max_balance
  attr_reader :min_balance
  attr_reader :min_fare
  attr_reader :entry_station
  attr_reader :stations

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
    @min_balance = MIN_BALANCE
    @min_fare = MIN_FARE
    @entry_station
    @exit_station
    @stations = []
  end

  def top_up(deposit)
    fail 'Max balance reached' if full?(deposit)
    @balance += deposit
  end

  def full?(deposit)
    (@balance + deposit) > max_balance
  end

  def touch_in(station)
    @entry_station = station
    fail 'Not enough funds' if (@balance < min_balance)
  end

  def touch_out(station)
    deduct(min_fare)
    @exit_station = station
    add_station
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    entry_station != nil
  end

  def add_station
    @stations << {entry: @entry_station, exit: @exit_station}
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end

class Station

end
