require 'station'

describe Station do 
  it "returns the name of the station" do
    station = Station.new("liverpool",1)
    expect(station.name).to eq "liverpool"
  end

  it "returns the number of the zone" do
    station = Station.new("liverpool",1)
    expect(station.zone).to eq 1
  end
end