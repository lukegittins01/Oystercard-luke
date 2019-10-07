class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :max_balance
  attr_reader :min_balance

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
    @min_balance = MIN_BALANCE
    @in_or_out = false
  end

  def top_up(deposit)
    fail 'Max balance reached' if full?(deposit)
    @balance += deposit
  end

  def deduct(fare)
    @balance -= fare
  end

  def full?(deposit)
    (@balance + deposit) > max_balance
  end

  def touch_in
    fail 'Not enough funds' if (@balance < min_balance)
    @in_or_out = true
  end

  def touch_out
    @in_or_out = false
  end

  def in_journey?
    @in_or_out
  end

end
