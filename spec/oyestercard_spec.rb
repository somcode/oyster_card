require 'oyestercard'

describe Oyestercard do

  let(:fake_station1) { double :fake_station1 }
  let(:fake_station2) { double :fake_station2 }

  maximum_balance = Oyestercard::MAXIMUM_BALANCE
  minimum_fare = Oyestercard::MINIMUM_FARE
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'card has a empty journey list' do
    expect(subject.journey_list).to eq([])
  end

  describe "#top_up" do
    it 'responds to top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
  end

  it 'top up the balance' do
    expect { subject.top_up(1) }.to change { subject.balance }.by(1)
  end
  it 'raise an error when try to top_up more then balance limit' do
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error " Maximum balance of #{maximum_balance} exceeded "
  end

  describe "#touch_in" do
    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end
    it 'checking minimum balance on touch in' do
      expect{ subject.touch_in(fake_station1) }.to raise_error "you dont have enough credit"
    end
    it 'save entry station' do
      subject.top_up(minimum_fare)
      expect { subject.touch_in(fake_station1) }.to change { subject.entry_station }.from(nil).to(fake_station1)
    end
  end

  describe "#touch_out" do
    it 'respond to touch out with one argument' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end
    it 'charging for the journey' do
      expect{ subject.touch_out(fake_station2) }.to change { subject.balance }.by(-minimum_fare)
    end
    it 'set entry station to nil at check out' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_station1)
      expect { subject.touch_out(fake_station2) }.to change { subject.entry_station }.from(fake_station1).to(nil)
    end
    it 'save the exit station' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_station1)
      expect { subject.touch_out(fake_station2) }.to change { subject.exit_station }.from(nil).to(fake_station2)
    end
    it 'save the journey list' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_station1)
      expect { subject.touch_out(fake_station2) }.to change { subject.journey_list }.from([]).to([{ entry: fake_station1, exit: fake_station2 }])
    end

  end

  describe "#in_journey?" do
    it 'responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end
    it 'shows the status when you are in journey' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_station1)
      expect(subject.in_journey?).to eq(true)
    end
    it 'shows the status when you are not in journey' do
      subject.touch_out(fake_station2)
      expect(subject.in_journey?).to eq(false)
    end
  end


end
