require_relative 'rapper'
require_relative 'speech'

module Battles
  class Parser
    def self.rappers
      Parser.new.rappers
    end

    def initialize
      @texts = parse_files
    end

    def rappers
      create_rappers
    end

    private

    attr_accessor :texts

    def parse_files
      empty_texts = Hash.new { |hash, key| hash[key] = [] }
      Dir['rap-battles/*'].each_with_object(empty_texts) do |path, texts|
        name = File.basename(path).split(/против|VS|vs/).first.strip
        texts[name] << File.read(path)
      end
    end

    def create_rappers
      texts.map do |name, speeches|
        Rapper.new(name, speeches)
      end
    end
  end
end
