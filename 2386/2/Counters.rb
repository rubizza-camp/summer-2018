require 'russian_obscenity'

# Class with count logic =)
class Counters
  PATH_FOLDER = 'Rapbattle'.freeze
  def self.count_normal(battles)
    words = battles.sum do |battle|
      Dir.chdir(PATH_FOLDER) { File.read(battle) }
         .gsub(/[.!-?,:]/, ' ').strip.split.count
    end
    words / (battles.size * 3)
  end

  def self.count_bad(battles)
    # Broke on 3 strings because of Rubocop
    battles.sum do |battle|
      count_bad_words(Dir.chdir(PATH_FOLDER) { File.read(battle) })
    end
  end

  def self.count_bad_words(file)
    file.count('*') + file.split.count do |word|
                        RussianObscenity
                      .obscene?(word)
                      end
  end
end
