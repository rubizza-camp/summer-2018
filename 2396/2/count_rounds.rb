require './data_rapers'

module RoundDataCollection
  def fetch_data_rounds(rap_files)
    count_rounds, count_words = 0
    rap_files.each do |file|
      count_rounds += hand_data_round(file)[:count_rounds]
      count_words  += hand_data_round(file)[:count_words]
    end
    { count_rounds: count_rounds, count_words: count_words }
  end

  def hand_data_round(file)
    text = File.read(file)
    count_words = DataRapers::Battle.clearing_text_from_garbage(text).size
    meaning = text.split(/Раунд\s[0-9]\./).size
    { count_rounds: handing_size_round(meaning), count_words: count_words }
  end

  def handing_size_round(count_rounds)
    (count_rounds.zero? ? 1 : count_rounds - 1)
  end
end
