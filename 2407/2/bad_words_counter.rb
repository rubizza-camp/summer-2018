require 'russian_obscenity'

# Counts obscene words
class BadWordsCounter
  def self.count(battles)
    total_bad_words = 0
    battles.each do |battle|
      total_bad_words += count_bad_words(Dir.chdir(INPUT_FOLDER) { File.read(battle) })
    end
    total_bad_words
  end

  def self.count_bad_words(file)
    local_bad_words = 0
    file.split.each do |word|
      local_bad_words += 1 if RussianObscenity.obscene?(word)
    end
    local_bad_words += file.count('*')
    local_bad_words
  end
end
