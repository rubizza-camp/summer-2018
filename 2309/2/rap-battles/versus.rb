require 'terminal-table'
# This method smells of :reek:TooManyInstanceVariables
# This method smells of :reek:TooManyStatements
# This method smells of :reek:NestedIterators
# rubocop:disable Style/GlobalVars
# rubocop:disable Metrics/MethodLength
# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/EmptyElse
# rubocop:disable Metrics/ClassLength
class AllRapers
  attr_reader :all_rapers, :sum_batles, :bad_words, :all_words, :sort_bw, :one_raper_words, :sort_raper_word

  def initialize
    @all_rapers = {}
    @sum_batles = {}
    @all_words = {}
    @bad_words = {}
    @sort_bw = []
    @one_raper_words = {}
    @sort_raper_word = []
  end

  def count_words_raper(name_r)
    namee = name_r
    pretext = read_file('предлоги')

    if @all_rapers.include? namee
      @all_rapers[namee].each do |val|
        text = read_file(' ' + val)
        text.gsub!(/[,-.!?&:;()1234567890%]/, ' ')
        text = text.downcase
        text = text.split
        text.each do |word|
          unless pretext.include? word
            if @one_raper_words.include? word
              @one_raper_words[word] += 1
            else
              @one_raper_words[word] = 1
            end
          end
        end
      end
    else
      nil
    end
  end
  # rubocop:enable Style/EmptyElse
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Lint/UnneededCopDisableDirective
  # rubocop:enable Metrics/MethodLength

  def sort_words
    @one_raper_words.each { |key, value| @sort_raper_word.push([value, key]) }
    @sort_raper_word.sort! { |first, last| last <=> first }
    @sort_raper_word.delete_at(0)
  end

  # This method smells of :reek:UtilityFunction
  def list_all_files
    Dir['*']
  end

  # This method smells of :reek:UtilityFunction
  def read_file(file)
    IO.read(file)
  end

  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:TooManyStatements
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Style/For
  # rubocop:disable Style/Next
  # rubocop:disable Metrics/BlockNesting
  def spis_rapers
    files = list_all_files
    repeat_names = { 'Billy Milligan' => ["Billy Milligan'а"],
                     'Galat' => ["Galat'a", 'Галат', 'Галата', 'Galat '],
                     'John Rai' => ['John rai'],
                     'Johnyboy' => ["Johnyboy'a"],
                     'Oxxxymiron' => ["Oxxxymiron'a", 'Oxxxymirona'],
                     'Артем Лоик' => ['Артема Лоика', 'Лоика'],
                     'Басота' => ['Басоты'],
                     'Букер' => ['Букера'],
                     'Гарри Топор' => ['Гарри Топора'],
                     'Гнойный' => ['Соня Мармеладова aka Гнойный', 'Гнойный aka Слава КПСС'],
                     'Дуня' => ['Дуни'],
                     'Замай' => ['Замая'],
                     'Илья Мирный' => ['Ильи Мирного'],
                     'Витя Classic' => ["Вити Classic'a ", 'Витя CLassic'] }

    for line in files

      if line.length > 10
        marker = 0
        line = line[1...line.size]

        if line.include? 'против'
          ind = line.index('против')

        elsif line.include? 'vs'
          ind = line.index('vs')

        elsif line.include? 'VS'
          ind = line.index('VS')
        end

        namee = line[0...ind - 1]

        for key in repeat_names.keys
          repeat_names[key].each do |val|
            if namee == val
              if @all_rapers.include? key
                @all_rapers[key] += [line]
              else
                @all_rapers[key] = [line]
              end
              marker += 1
            end
          end
        end
        if marker.zero?
          if @all_rapers.include? namee
            @all_rapers[namee] += [line]
          else
            @all_rapers[namee] = [line]
          end
        end
      end
    end
  end

  def count_sum_battles
    keys = @all_rapers.keys
    keys.each do |key|
      sum = @all_rapers[key].size
      @sum_batles[key] = sum
    end
  end

  # This method smells of :reek:DuplicateMethodCall
  # rubocop:disable Style/AndOr
  # rubocop:disable Style/IfUnlessModifier
  def search_bad_words
    files = list_all_files

    for key in @all_rapers.keys
      @bad_words[key] = 0
      @all_words[key] = 0
      mat = read_file('маты')
      not_mats = read_file('не маты')

      for line in files
        if line.include? key and line.index(key) == 1
          text = read_file(line)
          text.downcase!
          text.gsub!(/[^a-z а-я ё 1-9 0 * \n]/, ' ')
          for word in text.split
            @all_words[key] += 1
            counter = 0
            if word.include? '*'
              @bad_words[key] += 1
            else
              for mat_word in mat.split
                if word.include? mat_word
                  for no_mat in not_mats.split
                    if word.include? no_mat
                      counter += 1
                    end
                  end
                  if counter.zero?
                    @bad_words[key] += 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  # rubocop:enable Style/IfUnlessModifier
  # rubocop:enable Style/AndOr

  def sort_bad_words
    @bad_words.each { |key, value| @sort_bw.push([value, key]) }
    @sort_bw.sort! { |first, last| last <=> first }
  end
end
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/BlockNesting
# rubocop:enable Style/Next
# rubocop:enable Style/For
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity

$rapers = AllRapers.new
$rapers.spis_rapers
$rapers.count_sum_battles
$rapers.search_bad_words
$rapers.sort_bad_words

# This method smells of :reek:FeatureEnvy
# This method smells of :reek:TooManyStatements
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/HashSyntax
def build_table(lines)
  rows = []
  ind = 0

  while lines != 0
    raper = $rapers.sort_bw[ind][1]
    num_battles = $rapers.sum_batles[raper]
    num_bad_words = $rapers.bad_words[raper]
    bw_on_battle = (num_bad_words.to_f / num_battles.to_f).round(2)
    word_on_raund = $rapers.all_words[raper] / num_battles / 3
    rows << [raper, "#{num_battles} батлов", "#{num_bad_words} нецензурных слов",
             "#{bw_on_battle} слова на баттл", "#{word_on_raund} слова в раунде"]
    ind += 1
    lines -= 1
  end
  table = Terminal::Table.new :rows => rows
  puts table
end
# rubocop:enable Style/HashSyntax
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/IfInsideElse
# rubocop:disable Lint/UnusedBlockArgument
# rubocop:disable Metrics/BlockNesting
# rubocop:disable Style/IfUnlessModifier
marker = 30

arguments = ARGV

arguments.each do |arg|
  if arg == '--help'
    help = IO.read('help')
    help = help.split("\n")
    help.each do |line|
      puts line
    end
  elsif arg.include? '--top-bad-words='
    num_bad_words = arg[16..arg.size]
    num_bad_words = num_bad_words.to_i
    build_table(num_bad_words)
  else
    if arg.include? '--top-words='
      marker = arg[12..arg.size]
      marker = marker.to_i
    elsif arg.include? '--name='
      name_r = arg[7..arg.size]
      if arguments.index(arg) != arguments.size - 1
        name_r += " #{arguments.last}"
      end
      if $rapers.count_words_raper(name_r).nil?
        puts "Рэпер #{name_r} не известен мне. Зато мне известны:"
        $rapers.all_rapers.each { |key, value| puts key.to_s }
      else
        $rapers.count_words_raper(name_r)
        $rapers.sort_words
        $rapers.sort_raper_word.each do |word|
          puts "#{word[1]} - #{word[0]} раз"
          marker -= 1
          if marker.zero?
            break
          end
        end
      end
    end
  end
end
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Metrics/BlockNesting
# rubocop:enable Lint/UnusedBlockArgument
# rubocop:enable Style/IfInsideElse
# rubocop:enable Metrics/BlockLength
# rubocop:enable Style/GlobalVars
