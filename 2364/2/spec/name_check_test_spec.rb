require_relative '../name_checker'

describe NameChecker do
  it 'check two names' do
    check = NameChecker.new('Oxxxymiron', "Oxxxymiron'a").run
    expect(check).to be_truthy
  end

  it 'check two names' do
    check = NameChecker.new('Oxxymiron', "Oxxxymiron'a").run
    expect(check).to be_falsy
  end
end
