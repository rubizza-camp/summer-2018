require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe Participant do
  it 'check if class of participant Participant' do
    participant = Participant.new(nil, rounds: 1, words_per_battle: 0, bad_words: 0, text: '')
    expect(Participant).to eq participant.class
  end

  it 'check row of participant' do
    participant = Participant.new(nil, rounds: 1, words_per_battle: 0, bad_words: 0, text: '').to_str
    first_row = [nil, '1 батлов', '0 нецензурных слов']
    second_row = ['0.0 слова на баттл', '0 слова в раунде']
    row = first_row + second_row
    expect(row).to eq participant
  end
end
