class BadWordsAnalizator
  # initialize all criterias for the table
  def initialize
    @bad_words_num = 0
    @battles_num = 0
    @all_words_num = 0
    @raund_num = 0
  end

  def collect_inf_about(participant_name, file_names, participants_bad_words)
    file_names.each do |file_name|
      read_battle(file_name) if check_if_the_right_battle(file_name, name)
    end
    @raund_num = 1 if @raund_num.zero?
    participants_bad_words[participant_name] = [@battles_num, @bad_words_num, @bad_words_num / @battles_num,
                                                @all_words_num.div(@raund_num)]
  end

  private

  def check_if_the_right_battle(file_name, name)
    file_name[file_name.index('/') + 1..-1].strip.index(name) &&
      file_name[file_name.index('/') + 1..-1].strip.index(name).zero?
  end

  def read_battle(file_name)
    words = divide_into_words(file_name)
    count_criterias(words)
  end

  def divide_into_words(name_of_file)
    text = ''
    round_text = ''
    File.open(name_of_file, 'r').each_line { |line| define_round(text, round_text, line) }
    get_rest_text(text, round_text)
  end

  def define_round(content, round_content, line_of_battle)
    if check_if_round(line_of_battle, round_content)
      content << round_content
      @raund_num += 1
    else
      round_content << line_of_battle + ' '
    end
  end

  def check_if_round(line_of_battle, round_content)
    line_of_battle.match(/Раунд [1|2|3][^\s]*/) && round_content != ''
  end

  def get_rest_text(text, round_text)
    text << round_text
    text.split(' ').select! { |word| word.match(/[^\s]+[a-zA-Z]*[а-яА-я]*[^\s]+/) }
  end

  def count_criterias(words)
    @all_words_num += words.size
    @battles_num += 1
    @bad_words_num += words.select! do |word|
      word.include?('*') || word.include?('(.') ||
        RussianObscenity.obscene?(word)
    end .size
  end
end
