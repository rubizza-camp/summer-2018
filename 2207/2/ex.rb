require 'russian_obscenity'
PATH_FOLDER = 'texts'.freeze

  def find_rapers_titles(raper)
    rapers_titles = []
    Dir.chdir(PATH_FOLDER) do
      Dir.glob("*#{raper}*").each do |title|
        rapers_titles << title if title.split('против').first.include? raper
      end
    end
    rapers_titles
  end

def read_files_with_buttles(battle)
      Dir.chdir(PATH_FOLDER) { File.read(battle) }
 end
  def count_bad_words(file)
#    bad_words = []
#    file.split.each do |word|
#      bad_words << word if RussianObscenity.obscene?(word)
#    end
#    bad_words.count
  file.split.each_with_object([]) { |word1, arr| arr << word1  }
  end
a = read_files_with_buttles('1')
p count_bad_words a
