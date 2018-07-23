require_relative '../participant'

describe Participant do
  it 'check row of participant' do
    participant = Participant.new(nil).to_str
    first_row = [nil, '0 батлов', '0 нецензурных слов']
    second_row = ['0 слова на баттл', '0 слова в раунде']
    row = first_row + second_row
    expect(participant).to eq(row)
  end
end
