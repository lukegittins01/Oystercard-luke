require 'oystercard'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'adds money to balance' do
    deposit = rand(10)
    subject.top_up(deposit)
    expect(subject.balance).to eq(deposit)
  end

  it 'has a max balance' do
    subject.top_up(80)
    expect { subject.top_up(15) }.to raise_error 'Max balance reached'
  end

  # it 'deducts the balance' do
  #   subject.top_up(40)
  #   subject.deduct(20)
  #   expect(subject.balance).to eq(20)
  # end

  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#touch_in' do
    let(:station1){ double :station }

    it "can touch in" do
      subject.top_up(10)
      subject.touch_in(station1)
      expect(subject).to be_in_journey
    end

    it 'can remember entry station' do
      subject.top_up(10)
      subject.touch_in(station1)
      expect(subject.entry_station).to eq (station1)
    end
  end

  it "can touch out" do
    subject.top_up(1)
    subject.touch_in('Acton Town')
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'does not touch in if funds are too low' do
    expect { subject.touch_in('Acton Town') }.to raise_error 'Not enough funds'
  end

  it 'deducts minimum fare' do
    subject.top_up(10)
    expect {subject.touch_out}.to change{subject.balance}.by(-2)
  end

  it 'sets station to nil' do
    subject.top_up(1)
    subject.touch_in('Acton Town')
    subject.touch_out
    expect(subject.entry_station).to be nil
  end

end
