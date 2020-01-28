class Oystercard
    attr_reader :balance 

    MAX_BALANCE = 90
    def initialize
        @balance = 0
        @in_journey = false
    end

    def top_up(amount)

      raise "Max balance of #{MAX_BALANCE} exceeded" if (@balance + amount) > MAX_BALANCE
      @balance = @balance + amount
    end

    def deduct(amount)
      @balance = @balance - amount
    end

    def in_journey?
      @in_journey
    end

    def touch_in
      @in_journey = true
    end

    def touch_out
      @in_journey = false
    end

end 