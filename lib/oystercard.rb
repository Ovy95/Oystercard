class Oystercard
    attr_reader :balance, :in_journey, :entry_station, :exit_station
    attr_accessor :journeys

    MAX_BALANCE = 90
    MINIMUM_CHARGE = 5
    MINIMUM_BALANCE = 5
    def initialize(balance = 0)
        @balance = balance
        @in_journey = false
        @entry_station = nil
        @journeys = []
        @exit_station = nil
    end

    def top_up(amount)

      raise "Max balance of #{MAX_BALANCE} exceeded" if (@balance + amount) > MAX_BALANCE
      @balance = @balance + amount
    end
    
    def in_journey?
      !!entry_station
      # @entry_station == nil ? false : true
    end

    def touch_in(station)
      fail "Insufficient balance to touch in" if  @balance < MINIMUM_CHARGE
      @entry_station = station
      @in_journey = true

    end

    def touch_out(station)
     deduct(MINIMUM_CHARGE)
     @entry_station
     @in_journey = false
  
     @exit_station = station
     @journeys << {entry_station: @entry_station, exit_station: @exit_station}
    
    end

    private
    def deduct(amount)
      @balance -= amount
    end

end 