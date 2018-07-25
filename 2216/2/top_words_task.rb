class TopWordsTask
  attr_reader :num_of_top, :name

  def initialize(num_of_top, name)
    @num_of_top = num_of_top
    @name = name
  end

  def run_top_words_analysis
    battle_words = make_battle_words
    analyzer = TopWordsAnalyzer.new(battle_words)
    print_result(analyzer.analyze_top)
  end

  private

  def make_battle_words
    battle_words = []
    participant = Rapper.new(name)
    participant.battles.each { |battle| battle_words += battle.words }
    battle_words
  end

  def print_result(top_words)
    Integer(num_of_top).times do
      word_with_count = top_words.shift
      puts "#{word_with_count[0]} - #{word_with_count[1]} раз"
    end
  end
end
