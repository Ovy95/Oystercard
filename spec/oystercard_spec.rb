require 'Oystercard'

describe Oystercard do

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

  describe "#deduct" do 
    it " takes the amount checkes entered amount" do 
      expect(subject).to respond_to(:deduct).with(1).argument 
    end

    it "deducts the fare from the balance " do 
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

  describe "#In journey" do
    it " Initally not in journey" do 
      expect(subject).to_not be_in_journey
    end 

    it "can touch in " do 
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "can touch out " do 
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

  end


end