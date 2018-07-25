# Parsing folders with battles texts
class Parser
  def self.getting_path
    Dir[File.dirname(__FILE__) + '/rap-battles/*']
  end
end
