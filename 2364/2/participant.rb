require_relative 'count_words.rb'
require_relative 'participant.rb'

# Class participant with data:
# name of participant, number of all battles,
# all bad words for life, numbers of
# round, words that participant said
class Participant
  attr_reader :name, :battles, :participant_data
  def initialize(name, data)
    @name = name
    @battles = 0
    @participant_data = { rounds: 0, words_amount: 0, bad_words: 0, all_texts: '' }
    update_data(data)
  end

  def update_data(data)
    @battles += 1
    @participant_data[:rounds] += data[:rounds]
    @participant_data[:words_amount] += data[:words_per_battle]
    @participant_data[:bad_words] += data[:bad_words]
    @participant_data[:all_texts] += data[:text]
  end

  def count_words(value)
    words = participant_data[:all_texts]
    CountWords.new(words, value).output_words
  end

  def to_str
    average_words = check_average_words
    average_bad_words = check_average_bad_words
    create_row(average_words, average_bad_words)
  end

  def check_average_bad_words
    if battles.zero?
      0
    else
      (participant_data[:bad_words].to_f / battles).round(2)
    end
  end

  def check_average_words
    rounds = participant_data[:rounds]
    if rounds.zero?
      0
    else
      participant_data[:words_amount] / rounds
    end
  end

  def create_row(average_words, average_bad_words)
    first_row = [name, "#{battles} батлов", "#{participant_data[:bad_words]} нецензурных слов"]
    second_row = ["#{average_bad_words} слова на баттл", "#{average_words} слова в раунде"]
    first_row + second_row
  end
end
