require 'Oystercard'

describe Oystercard do

    it "(1) Has a balance of zero" do
    expect(subject.balance).to eq(0)
    end

    describe '#top_up' do
    it "(2) Is expected to top up the balance" do
    expect(subject).to respond_to(:top_up).with(1).argument

    it " tops up the balance" do
        expect(subject.top_up(1).to change(subject.balance).by 1
    end
    end
end 