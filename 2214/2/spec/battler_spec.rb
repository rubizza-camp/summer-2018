require_relative '../battler'

describe Battler do
  battles = ['Говно залупа пенис хер', 'Главное правильно подать', 'Скажи американец, в чем сила']
  oxxxy = Battler.new('Oxxxymiron', battles)
  it 'has method which returns number of battles' do
    expect(oxxxy.number_of_battles).to be_kind_of(Integer)
    expect(oxxxy.number_of_battles).to eql(3)
  end
end
