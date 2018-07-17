require_relative './file_parser.rb'
# calculate the most popular words in battlers text
class TopWords
  attr_reader :statistic

  ACCEPTABLE_LENGTH = 3
  JUNK_WORDS = %w[я quot ты он она оно мы вы они в без типа
                  до из к как на по о от перед при через с что
                  у за над об под про для от по тебя меня ее его
                  ее тебе как это и а или если будто так
                  мне мой мои твоя твое твои твой твою твоей чтоб
                  все всё себя чтобы бы ведь когда тогда кем чем там
                  уже есть такой какой такой этот где тут cловно ещё].freeze

  def popular_words(name)
    warning_about_wrong_name(name)
    clear_list = clean_text(name)
    clear_list.uniq.each { |word| statistic[word] = clear_list.count(word) }
    sort_list
  end

  def initialize(size)
    @hash = FileParser.new.read_files
    @statistic = Hash.new(0)
    @size = size.to_i
  end

  private

  def warning_about_wrong_name(name)
    return if @hash.key?(name)
    rapers_exampels = @hash.keys.sample
    raise "Такого исполнителя нет,зато есть '#{rapers_exampels}'"
  end

  def clean_text(name)
    @hash[name].join(' ').split(' ').delete_if do |word|
      word.length < ACCEPTABLE_LENGTH || JUNK_WORDS.include?(word)
    end
  end

  def sort_list
    statistic.sort_by { |_, key| key }.reverse.first(@size).each do |result|
      puts "#{result.first.capitalize}-- #{result.last}"
    end
  end
end
