require_relative 'work_with_dir'
require_relative 'battler'
require_relative 'top_word'
# require 'russian_obscenity'

class WorkWithBattles
  PREPOSITIONS = 'prepositions'.freeze

  def self.take_all_battlers
    WorkWithDir.take_all_battles.map { |el| WorkWithBattles.out_name_bat(el) }.uniq
  end

  def self.out_name_bat(title)
    title.split('против')[0].strip
  end

  def self.get_all_text(name_bat)
    text_with_count = [[], 0]
    WorkWithDir.take_all_battles.map do |el|
      if out_name_bat(el).eql?(name_bat)
        text_with_count[0] += WorkWithDir.take_text_battler(el).split(' ')
        text_with_count[1] += 1
      end
    end
    text_with_count
  end

  def self.get_all_words(text_bat)
    words = []
    prepositions = File.read(PREPOSITIONS).split(',')
    text_bat.uniq.map do |el|
      words << TopWord.new(el, text_bat.count(el)) unless prepositions.include?(el)
    end
    words.sort_by(&:count).reverse
  end

  def self.top_words(name_bat)
    text_bat = get_all_text(name_bat)[0]
    if text_bat.empty?
      puts "Рэпер #{name_bat} мне не известен. Выберите из списка:"
      puts take_all_battlers
      []
    else
      get_all_words(text_bat)
    end
  end

  def self.check_bad_word(text_bat)
    change_text = RussianObscenity.sanitize(text_bat, '<CR>')
    change_text.scan('<CR>').size + change_text.count('*')
  end

  def self.init_bat(params)
    # multiplication of params[0] by 3. 3 is the number of rounds in the battle
    Battler.new(params[3], params[0], params[1], (Float(params[1]) / params[0]).round(2), params[2] / (params[0] * 3))
  end

  def self.analysis_battler(name_bat)
    text_with_count = get_all_text(name_bat)
    init_bat([text_with_count[1], check_bad_word(text_with_count[0].join(' ')), text_with_count[0].size, name_bat])
  end

  def self.top_battlers(list_battlers)
    battlers = []
    list_battlers.each do |el|
      battlers << analysis_battler(el)
    end
    battlers.sort_by { |el| el.params[2] }.reverse
  end

  def self.tabular_output(rows_arr, headings)
    rows = []
    rows_arr.map { |el| rows << el.show }
    table = Terminal::Table.new(headings: headings, rows: rows)
    puts table
  end
end
