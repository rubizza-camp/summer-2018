require_relative '../statistic.rb'

describe Statistic do
  it 'is able to be created' do
    expect(Statistic.new).to be_kind_of(Statistic)
  end

  it 'has instance variable @data' do
    stats = Statistic.new
    expect(stats.data).to be_kind_of(Hash)
  end
end
