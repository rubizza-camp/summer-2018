require 'terminal-table'

# This method smells of :reek:IrresponsibleModule
# This method smells of :reek:TooManyInstanceVariables
# This method smells of :reek:TooManyMethods
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

  def create_all_rapers
    spis_rapers
  end

  def create_sum_batles
    count_sum_battles
  end

  def create_all_words
    count_sum_battles
  end

  def create_search_bad_words
    search_bad_words
  end

  def create_sort_bad_words
    sort_bad_words
  end

  def create_sort_words
    sort_words
  end

  def create_count_words_raper(namee)
    count_words_raper(namee)
  end

  private

  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Style/EmptyElse
  # rubocop:disable Lint/UselessAssignment
  def format_text(val)
    text = read_file(' ' + val)
    text.gsub!(/[,-.!?&:;()1234567890%»]/, ' ')
    text = text.downcase
    text = text.split
  end
  # rubocop:enable Lint/UselessAssignment
  # rubocop:enable Style/EmptyElse

  # This method smells of :reek:NestedIterators
  # rubocop:disable Style/EmptyElse
  def count_words_raper(namee)
    if @all_rapers.include? namee
      @all_rapers[namee].each do |val|
        format_text(val).each do |word|
          unless read_file('предлоги').include? word
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

  # This method smells of :reek:UtilityFunction
  def open_file(name_file)
    File.open(name_file)
  end

  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Style/For
  # rubocop:disable Style/Next
  # rubocop:disable Style/IfUnlessModifier
  def spis_rapers
    list_all_files.each do |battle|
      if battle.length > 15
        if battle.include? 'против' then vs = 'против' end
        if battle.include? 'VS' then vs = 'VS' end
        if battle.include? 'vs' then vs = 'vs' end
        if battle.include? vs
          namee = battle[0...battle.index(vs) - 1]
          battle = battle[1...battle.size]
          variable_name(namee, battle)
        end
      end
    end
  end
  # rubocop:enable Style/IfUnlessModifier

  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Style/IfUnlessModifier
  def variable_name(namee, battle)
    open_file('варианты_имен').each do |names|
      names.chomp!
      if names.include? namee then namee = names.split(', ')[0] end
    end
    add_name(namee, battle)
  end
  # rubocop:enable Style/IfUnlessModifier

  def add_name(namee, line)
    if @all_rapers.include?(namee)
      @all_rapers[namee] += [line]
    else
      @all_rapers[namee] = [line]
    end
  end

  def count_sum_battles
    keys = @all_rapers.keys
    keys.each do |key|
      sum = @all_rapers[key].size
      @sum_batles[key] = sum
    end
  end

  # This method smells of :reek:FeatureEnvy
  def format_text_battle(battle)
    text = read_file(battle)
    text.downcase!
    text.gsub!(/[^a-z а-я ё 1-9 0 * \n]/, ' ')
  end

  # This method smells of :reek:TooManyStatements
  # rubocop:disable Style/AndOr
  def search_bad_words
    files = list_all_files

    for key in @all_rapers.keys
      @bad_words[key] = 0
      @all_words[key] = 0
      files.each do |line|
        if line.include? key and line.index(key) == 1
          for word in format_text_battle(line).split
            test_for_a_bad_word(word, key)
          end
        end
      end
    end
  end
  # rubocop:enable Style/AndOr

  def add_bad_word(namee)
    @bad_words[namee] += 1
  end

  def add_all_words(namee)
    @all_words[namee] += 1
  end

  # This method smells of :reek:DuplicateMethodCall
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:NestedIterators
  # rubocop:disable Style/OneLineConditional
  def test_for_a_bad_word(word, namee)
    add_all_words(namee)
    mat = read_file('маты')
    not_mats = read_file('не маты')
    if word.include? '*'
      add_bad_word(namee)
    else
      mat.split.each do |bad_word|
        if word.include? bad_word
          not_mats.split.each do |good_word|
            if word.include? good_word then else add_bad_word(namee) end
          end
        end
      end
    end
  end

  def sort_bad_words
    @bad_words.each { |key, value| @sort_bw.push([value, key]) }
    @sort_bw.sort! { |first, last| last <=> first }
  end
end
# rubocop:enable Style/OneLineConditional
# rubocop:enable Metrics/ClassLength
# rubocop:enable Style/Next
# rubocop:enable Style/For
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

$rapers = AllRapers.new
$rapers.create_all_rapers
$rapers.create_sum_batles
$rapers.create_search_bad_words
$rapers.create_sort_bad_words

# This method smells of :reek:TooManyStatements
# This method smells of :reek:FeatureEnvy
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
      if $rapers.create_count_words_raper(name_r).nil?
        puts "Рэпер #{name_r} не известен мне. Зато мне известны:"
        $rapers.all_rapers.each { |key, value| puts key.to_s }
      else
        $rapers.create_count_words_raper(name_r)
        $rapers.create_sort_words
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
