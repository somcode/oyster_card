require 'journey'
describe Journey do

  let(:fake_station1) { double :fake_station1 }
  let(:fake_station2) { double :fake_station2 }
  subject { described_class.new(:fake_station1) }

  it 'check the entry statin' do
    expect(subject.entry_station).to eq :fake_station1
  end

  describe "#set_exit_station" do
    it 'check the exit station' do
      subject.set_exit_station(fake_station2)
      expect(subject.exit_station).to eq fake_station2
    end
  end

  describe "#journey_complete" do
    it 'check the journey is complete or not' do
      subject.set_exit_station(fake_station2)
      expect(subject.journey_complete?).to eq true
    end
  end

  context 'when journey is complete' do
    it 'charge minimum fare' do
      subject.set_exit_station(fake_station2)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end

  context 'when journey is not complete' do
    it 'charge maximum fare' do
      expect(subject.fare).to eq Journey::MAXIMUM_FARE
    end
  end
end
