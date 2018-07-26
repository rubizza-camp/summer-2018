require_relative '../create_data'

describe DataCreater do
  it 'check finding of bad words' do
    data = DataCreater.new('spec/test_file.txt').run
    expect(data[:bad_words]).to eq(3)
  end

  it 'check counting of rounds' do
    data = DataCreater.new('spec/test_file.txt').run
    expect(data[:rounds]).to eq(1)
  end
end
