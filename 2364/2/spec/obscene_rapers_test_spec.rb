require_relative '../obscene_rapers'

describe ObsceneRapersFinder do
  it 'check creating table of obscene rapers' do
    file_path = Dir['./rap-battles/*']
    obscene_rapers = ObsceneRapersFinder.new(0, file_path)
    expect(obscene_rapers.participants.size).to eq(124)
  end

  it 'check creating table of obscene rapers' do
    file_path = Dir['./rap-battles/*']
    obscene_rapers = ObsceneRapersFinder.new(30, file_path)
    obscene_rapers.run
    expect(obscene_rapers.participants.size).to eq(30)
  end
end
