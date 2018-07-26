require_relative '../top_words'

describe TopWordsFinder do
  it 'check raper in topwordsfinder' do
    file_path = Dir['./rap-battles/*']
    top_words = TopWordsFinder.new(0, 'Rickey F', file_path)
    expect(top_words.participant.name).to eq('Rickey F')
  end

  it 'check raper in topwordsfinder' do
    file_path = Dir['./rap-battles/*']
    top_words = TopWordsFinder.new(0, 'Гриша', file_path)
    expect(top_words.participant).to eq(nil)
  end
end
