require 'station'
describe Station do

  subject { described_class.new('Finchley', 2) }
  it 'expect the station name' do
    expect(subject.name).to eq("Finchley")
  end
  it 'expect the station zone' do
    expect(subject.zone).to eq(2)
  end

end
