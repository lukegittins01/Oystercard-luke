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
    subject.touch_out('Uxbridge')
    expect(subject).not_to be_in_journey
  end

  it 'does not touch in if funds are too low' do
    expect { subject.touch_in('Acton Town') }.to raise_error 'Not enough funds'
  end

  it 'deducts minimum fare' do
    subject.top_up(10)
    expect {subject.touch_out('Uxbridge')}.to change{subject.balance}.by(-2)
  end

  it 'sets station to nil' do
    subject.top_up(1)
    subject.touch_in('Acton Town')
    subject.touch_out('Uxbridge')
    expect(subject.entry_station).to be nil
  end


  it 'pushes stations into a hash to store them' do
    entry1 = double(:station)
    exit1 = double(:station)
    #let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    subject.top_up(1)
    subject.touch_in(entry1)
    subject.touch_out(exit1)
    expect(subject.stations).to eq([{entry: entry1, exit: exit1}])
  end
end

describe Station do

  subject {described_class.new("Old Street", 1)}

  it 'knows its name' do
    expect(subject.name).to eq("Old Street")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(1)
  end
end
