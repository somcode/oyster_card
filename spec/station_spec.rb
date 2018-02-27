require 'station'
describe Station do

  station = Station.new({ name: "Moorgate", zone: 1 })
  # we can use this as a subject
  # subject {described_class.new(name: "Moorgate", zone: 1)}

  describe "#initialize" do
    it 'initialize station name' do
      expect(station.name).to eq "Moorgate"
    end
    it 'initialize station zone' do
      expect(station.zone).to eq(1)
    end
  end

end
