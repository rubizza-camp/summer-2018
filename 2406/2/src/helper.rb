module Helper
  require 'terminal-table'
  DEFAULT_RANGE = 30
  GARBAGE_FILEPATH = '../data/garbage_list.txt'.freeze

  def self.artist_exist(args)
    HelperDAO.artist_list.any? { |artist_base| args.join('') == artist_base.name.delete(' ') }
  end

  def self.exclude_garbage(indata)
    indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
    garbage_words = File.readlines(GARBAGE_FILEPATH).each(&:strip!)
    indata = indata.split(' ').select { |each_word| each_word.length >= 3 && !garbage_words.include?(each_word) }
    indata
  end

  def self.delete_round_name_lines(buffer)
    buffer.delete_if { |line| line.include?('раунд') || line.include?('Раунд') }.join('')
  end

  def format_load_from_file(file)
    file.slice(FILE_NAME_LENGTH, read_from_file(file).length)
  end

  def range_correction(range = DEFAULT_RANGE)
    Integer(range)
  end
end
