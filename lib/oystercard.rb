class Oystercard

  MAX_BALANCE = 90
  attr_reader :balance
  attr_reader :max_balance

  def initialize
    @balance = 0
    @max_balance = MAX_BALANCE
  end

  def top_up(deposit)
    fail 'Max balance reached' if full?(deposit)
    @balance += deposit
  end

  def full?(deposit)
    (@balance + deposit) > max_balance
  end

end
