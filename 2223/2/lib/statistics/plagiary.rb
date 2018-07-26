require_relative 'rapper_search'

module Statistics
  class Plagiary
    include RapperSearch

    def self.call(rappers, name)
      Plagiary.new(rappers, name).call
    end

    attr_reader :rappers, :name

    def initialize(rappers, name)
      @rappers = rappers
      @name = name
    end

    def call
      rapper = rapper_by_name(rappers, name)
      check_plagiat(rapper) if rapper
    end

    private

    def check_plagiat(rapper)
      other_rappers.each do |other_rapper|
        check_rhymes(rapper, other_rapper)
      end
    end

    def check_rhymes(verifiable_rapper, other_rapper)
      verifiable_rapper_rhymes = verifiable_rapper.rhymes
      other_rapper_rhymes = other_rapper.rhymes
      (verifiable_rapper_rhymes.keys & other_rapper_rhymes.keys).each do |rhyme|
        show_rhyme(verifiable_rapper.name, verifiable_rapper_rhymes[rhyme])
        show_rhyme(other_rapper.name, other_rapper_rhymes[rhyme])
      end
    end

    def other_rappers
      rappers.reject { |author| author.name == name }
    end

    def show_rhyme(name, rhyme)
      puts name
      puts rhyme
      puts '-' * 30
    end
  end
end
