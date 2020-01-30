require 'Oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }

  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it "(1) Has a balance of zero" do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it "(2) Is expected to top up the balance" do
      expect(subject).to respond_to(:top_up).with(1).argument 
    end

    it "(3) tops up the balance" do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "(4) raises an error is the balance is more then 90" do 
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect {subject.top_up(1)}.to raise_error "Max balance of #{max_balance} exceeded"
    end

  end

  describe "#In journey" do
    it " (1I) Initally not in journey" do 
      expect(subject).to_not be_in_journey

    end 

   it "expects to be in jounrey when checking in " do 
    min_balance = Oystercard::MINIMUM_BALANCE
    subject.top_up(min_balance)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
   end

    it "(2I)can touch in " do 
      min_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(min_balance)
      #Old code
      #expect(subject).to be_in_journey
      expect { subject.touch_in(entry_station) }.to change{ subject.in_journey }.to true

    end

    it "(3I) can touch out " do 
      oystercard = Oystercard.new(5)
      oystercard.touch_in(entry_station)
      expect{ oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
   
    end

    it "3 II Will change the journey status " do 
      min_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.in_journey }.to false
    end


    it "(4I)Will not touch in if below minimum balance" do 
      expect{ subject.touch_in(entry_station)}.to raise_error "Insufficient balance to touch in"
    end

    
    it '(5 I) stores the entry station' do
      oystercard = Oystercard.new(5)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    

    it '(7) stores a journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  

  
  end
end