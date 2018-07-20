# Class for parsing name
class NameParser
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def run
    return '(Pra(Killa\'Gramm)' if file_name.include? '(Pra(Killa\'Gramm)'
    name = file_name.split('/').last.split('(').first.split(/ против | vs | VS | & | && /).first.strip
    name
  end
end
