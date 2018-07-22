module Helper
  require 'terminal-table'
  DEFAULT_RANGE = 30

  def self.artist_exist(args)
    HelperDAO.artist_list.any? { |artist_base| args.join('') == artist_base.name.delete(' ') }
  end

  def self.exclude_garbage(indata)
    indata = indata.downcase.gsub(/[.,!?:;«»<>&'()]/, '')
    indata = indata.split(' ').select { |each_word| each_word.length >= 4 }
    indata
  end

  def self.read_from_buffer(buffer)
    parsed_text = ''
    buffer.each { |line| parsed_text += line if !line.include?('раунд') || !line.include?('Раунд') }
    parsed_text
  end

  def format_load_from_file(file)
    file.slice(FILE_NAME_LENGTH, read_from_file(file).length)
  end

  def range_correction(range)
    Integer(range)
  rescue ArgumentError
    DEFAULT_RANGE
  end
end
