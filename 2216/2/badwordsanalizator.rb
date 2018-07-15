class BadWordsAnalizator
  # initialize all criterias for the table
  def initialize
    @bad_words_num = 0
    @battles_num = 0
    @all_words_num = 0
    @raund_num = 0
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def collect_inf_about(participant_name, names_of_files, participants_bad_words)
    names_of_files.each do |file_name|
      next unless check_if_read_battle(file_name, participant_name)
      words = divide_into_words(file_name)
      @all_words_num += words.size
      @battles_num += 1
      @bad_words_num += count_bad_words(words)
    end
    @raund_num = 1 if @raund_num.zero?
    participants_bad_words[participant_name] = [@battles_num, @bad_words_num, @bad_words_num / @battles_num,
                                                @all_words_num.div(@raund_num)]
  end

  private

  # This method smells of :reek:UtilityFunction
  def check_if_read_battle(file_name, name)
    file_name.include?(name) && (file_name.index(name) == file_name.index('/') + 2 ||
    file_name.index(name) == file_name.index('/') + 1)
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def divide_into_words(name_of_file)
    text = ''
    raund_text = ''
    fname = File.open(name_of_file, 'r')
    fname.each_line { |line| identify_round(text, raund_text, line) }
    text << raund_text
    fname.close
    text = text.split(' ').select { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
  end

  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:UtilityFunction
  def identify_round(content, raund_content, line_of_battle)
    if line_of_battle.match(/Раунд [1|2|3][^\s]*/) && raund_content != ''
      content << raund_content
      @raund_num += 1
    else
      raund_content << line_of_battle + ' '
    end
  end

  # This method smells of :reek:UtilityFunction
  def count_bad_words(all_words)
    bad_words = all_words.select { |word| word.include?('*') || word.include?('(.') || RussianObscenity.obscene?(word) }
    bad_words.size
  end
end
