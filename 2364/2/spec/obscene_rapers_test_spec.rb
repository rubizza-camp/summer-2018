require_relative '../parser.rb'
require_relative '../participant.rb'
require_relative '../count_words.rb'
require_relative '../name_check.rb'
require_relative '../create_data.rb'

describe ObsceneRapers do
  it 'check if class of obscene_rapers ObsceneRapers' do
    obscene_rapers = ObsceneRapers.new(0, [])
    expect(ObsceneRapers).to eq obscene_rapers.class
  end

  it 'check rows' do
    obscene_rapers = ObsceneRapers.new(0, [])
    obscene_rapers.create_rows
    expect([]).to eq obscene_rapers.rows
  end
end
