require_relative './statistic.rb'

class TopBadWords < Statistic
  HEADINGS = ['Name', 'Amount of battles', 'Amount of bad words', 'Amount words on battle', 'Words on raund'].freeze

  def initialize(options)
    @amount = options[:top_bad_words]
    @result = []
    super()
  end

  def print_result
    prepare_result
    super(@result, HEADINGS)
  end

  private

  # :reek:FeatureEnvy
  def prepare_result
    data.first(@amount).each do |rapper, data_|
      words_per_round = Helper.words_per_round(data_['battles'])
      @result << [rapper, "#{data_['battles'].count} батлов", "#{data_['obscene_words']} нецензурных слов",
                  "#{data_['bad_words_on_battle']} слова на баттл", "#{words_per_round} cлова на раунд"]
    end
  end
end
