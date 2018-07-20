# Fetch data about rounds
class Round
  def initialize(rap_files)
    @rap_files    = rap_files
    @count_rounds = 0
    @count_words  = 0
  end

  def fetch_data
    @rap_files.each do |file|
      @count_rounds += hand_data(file)[:count_rounds]
      @count_words  += hand_data(file)[:count_words]
    end
    { count_rounds: @count_rounds, count_words: @count_words }
  end

  private

  def hand_data(file)
    text = File.read(file)
    count_words = DataBattle.clearing_text_from_garbage(text).size
    meaning = text.split(/Раунд\s[0-9]\./).size
    { count_rounds: handing_size_round(meaning), count_words: count_words }
  end

  def handing_size_round(count_rounds)
    (count_rounds.zero? ? 1 : count_rounds)
  end
end
