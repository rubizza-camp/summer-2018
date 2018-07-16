require 'optparse'
require 'terminal-table'
# :reek:UtilityFunction
def find_all_rappers
  rappers = []

  Dir.glob('rap/*') do |file_name|
    rapper = file_name.split('/').last.split(/против|VS\b|vs\b/)[0].strip
    rappers << rapper
  end
  rappers.uniq
end
# :reek:UtilityFunction
# :reek:TooManyStatements

def find_battles(name)
  all_battles = []

  Dir.glob('rap/*') do |file_name|
    battle = file_name.match(name)
    all_battles << battle
    all_battles.reject!(&:nil?)
  end
  all_battles.count
end
# :reek:UtilityFunction
# :reek:TooManyStatements

def find_bad_words(name)
  all_bad_words = []

  Dir.glob('rap/*') do |file_name|
    if file_name.match(name)
      text = File.read(file_name)
      bad_word = text.scan(/уй|сос|залуп/)
      all_bad_words << bad_word
    end
  end
  all_bad_words.flatten.count
end

def average_bad_words(name)
  avg = find_bad_words(name) / find_battles(name).to_f
  avg
end
# :reek:UtilityFunction
# :reek:TooManyStatements
# rubocop:disable Metrics/MethodLength

def find_average_round_words(name)
  battle_texts = []
  words_count = 0

  Dir.glob('rap/*') do |file_name|
    if file_name.match(name)
      text = File.read(file_name)
      battle_texts << text
    end
  end
  battle_texts.each do |battle|
    words_count += battle.split.count
  end
  avg = words_count / (battle_texts.count * 3)
  avg
end
# rubocop:enable Metrics/MethodLength

def battle_hash
  hash = find_all_rappers.each_with_object(Hash.new(0)) do |raper, total_bad_words|
    raper = raper
    total_bad_words[raper] += find_bad_words(raper)
  end
  hash.sort_by { |_raper, total_bad_words| total_bad_words }
end

OptionParser.new do |options|
  options.on('--top-bad-words=') do |number|
    table = Terminal::Table.new do |t|
      raper_name = battle_hash.reverse[0...number.to_i].to_h
      raper_name.each do |raper, bad_words|
        t << [raper, "#{find_battles(raper)} батлов", "#{bad_words} нецензурных слов",
              "#{average_bad_words(raper)} слов на баттл", "#{find_average_round_words(raper)} слов в раунде"]
      end
    end
    puts table
  end
end.parse!
