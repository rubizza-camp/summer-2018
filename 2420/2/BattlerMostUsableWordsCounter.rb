# rubocop:disable Style/MultilineBlockChain
# class BattlerMostUsableWordsCounter
class BattlerMostUsableWordsCounter
  FOLDER_PATH = Dir.pwd.freeze
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def run
    text_without_preposition.split(' ')
                            .each_with_object(Hash.new(0)) do |word, counter|
      counter[word] += 1
    end.to_a.sort_by { |_word, count| count }
    counter
  end

  private

  def text_without_preposition
    all_texts = text.downcase!
    prepositions_list = File.read("#{FOLDER_PATH}/prepositions").split(',')
    prepositions_list.inject(all_texts) { |texts, preposition| texts.gsub(/#{preposition}[аояиеёю ]/, '') }
  end
end
# rubocop:enable Style/MultilineBlockChain
