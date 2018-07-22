module Rap
  class CorrectStrings
    def self.full_string(battles, bad_words, average_bad)
      full_str = CorrectStrings.battles_to_s(battles) + CorrectStrings.bad_words_to_s(bad_words)
      full_str += CorrectStrings.average_bad_to_s(average_bad)
      full_str
    end

    def self.battles_to_s(battles)
      s_battles = "#{battles} баттл#{ending_of_numb_battles(battles)}"
      s_battles.ljust(10) + '| '
    end

    def self.ending_of_numb_battles(battles)
      two_last_digs = battles.digits.reverse.last(2).join.to_i
      return 'ов' if (11..19).cover?(two_last_digs)
      case two_last_digs.digits[0]
      when 1
        return ''
      when 2..4
        return 'а'
      end
      'ов'
    end

    def self.bad_words_to_s(bad_words)
      s_bad_words = "#{bad_words} нецензурн#{ending_of_nezenz_adj(bad_words)} слов#{ending_of_nezenz_noun(bad_words)}"
      s_bad_words.ljust(22) + '| '
    end

    def self.average_bad_to_s(average_bad)
      s_average = format('%1.2f', average_bad) + ' нецензурных слова на баттл'
      s_average.ljust(34) + '| '
    end

    def self.average_rounds(average)
      format('%1.2f', average) + ' слова в раунде в среднем'
    end

    def self.ending_of_nezenz_adj(bad_words)
      two_last_digits = bad_words.digits.reverse.last(2).join.to_i
      return 'ых' if (11..19).cover?(two_last_digits)
      return 'ое' if two_last_digits.digits[0] == 1
      'ых'
    end

    def self.ending_of_nezenz_noun(bad_words)
      two_last_digits = bad_words.digits.reverse.last(2).join.to_i
      return '' if (11..19).cover?(two_last_digits)
      case two_last_digits.digits[0]
      when 1
        return 'о'
      when 2..4
        return 'а'
      end
      ''
    end
  end
end
