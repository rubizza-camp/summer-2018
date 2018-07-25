# Class one battle
class Battle

	attr_reader :sum_bad_words, :sum_all_words

	def initialize(title)
    @title = title
    @sum_bad_words = 0
    @sum_all_words = 0
	end

	def read_bad_words
    IO.read('bad_words')
	end

	def read_battle
    text = IO.read("rap-battles/#{@title}")
    text.gsub!(/[,-.!?&:;()1234567890%»]/, ' ')
    text = text.downcase
    text = text.split
	end

  def count_bad_words
  	read_battle.each do |word|
  		if word.include? '*' then @sum_bad_words += 1 end
  	end
    bad_words = read_bad_words.split(', ')
    bad_words.each do |word|
    	@sum_bad_words += read_battle.count(word)
    end
  end

  def count_all_words
    @sum_all_words = read_battle.count
  end
end



