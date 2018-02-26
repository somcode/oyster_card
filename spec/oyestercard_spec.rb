require 'oyestercard'

describe Oyestercard do
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
    maximum_balance = Oyestercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error " Maximum balance of #{maximum_balance} exceeded "
  end
end
