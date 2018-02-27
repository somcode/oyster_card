require 'oyestercard'

describe Oyestercard do

  maximum_balance = Oyestercard::MAXIMUM_BALANCE
  minimum_fare = Oyestercard::MINIMUM_FARE
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
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
  # because we set deduct method to br private, we dont need to test this method anymore and we should remove it
  # describe "#deduct" do
  #   it 'responds to deduct method' do
  #     expect(subject).to respond_to(:deduct).with(1).argument
  #   end
  #   it 'deduct amount from balance' do
  #     subject.top_up(minimum_fare)
  #     expect {subject.deduct(1) }.to change { subject.balance }.by(-1)
  #   end
  # end

  describe "#touch_in" do
    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end
    it 'shows the status when you touch in' do
      subject.top_up(minimum_fare)
      expect{ subject.touch_in }.to change { subject.journey_status }.to(:in_transit)
    end
    it 'checking minimum balance on touch in' do
      expect{ subject.touch_in }.to raise_error "you dont have enough credit"
    end
  end

  describe "#touch_out" do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
    it 'shows the status when you touch_out' do
      subject.top_up(minimum_fare)
      subject.touch_in
      expect{ subject.touch_out }.to change { subject.journey_status }.to(:not_in_transit)
    end
    it 'charging for the journey' do
      expect{ subject.touch_out }.to change { subject.balance }.by(-minimum_fare)
    end
  end

  describe "#in_journey?" do
    it 'responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end
    it 'shows the status when you are in journey' do
      subject.top_up(minimum_fare)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
    it 'shows the status when you are not in journey' do
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
  end


end
