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

end
