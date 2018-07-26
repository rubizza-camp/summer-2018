class BadWordsTask
  attr_reader :num_of_top, :participants

  def initialize(num_of_top, participants)
    @num_of_top = num_of_top
    @participants = participants
  end

  def run_bad_words_analysis
    participant_bad_words = make_list_of_participants_bad_words
    print_result(participant_bad_words)
  end

  private

  def print_result(participant_bad_words)
    columns = participant_bad_words.min.flatten.size
    table = BadWordsTable.new(participant_bad_words, Integer(num_of_top), columns)
    table.print(:console)
  end

  def make_list_of_participants_bad_words
    participant_bad_words = {}
    participants.each do |name|
      participant = Rapper.new(name)
      participant_bad_words[name] = get_bad_words(participant)
    end
    participant_bad_words
  end

  def get_bad_words(participant)
    analyzer = BadWordsAnalyzer.new(get_battle_texts(participant), get_battle_words(participant),
                                    get_battle_rounds(participant))
    analyzer.analyze_bad
  end

  def get_battle_rounds(rapper)
    battle_rounds = 0
    rapper.battles.each { |battle| battle_rounds += battle.rounds }
    battle_rounds
  end

  def get_battle_texts(rapper)
    battle_texts = {}
    rapper.battles.each { |battle| battle_texts[battle.battle_title] = battle.text }
    battle_texts
  end

  def get_battle_words(rapper)
    battle_words = []
    rapper.battles.each { |battle| battle_words += battle.words }
    battle_words
  end
end
