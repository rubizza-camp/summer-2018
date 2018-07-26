# In this class an array of participant data is generated for all battles:
# - name of participant
# - number of battles
# - bad words
# - bad words / number of battles
# - words in round
class RapersArray
  include Sum
  attr_reader :array, :choice_batlers, :all_batlers, :mens
  def initialize(mens, choice_batlers, all_batlers)
    @array = []
    @mens = mens
    @choice_batlers = choice_batlers
    @all_batlers = all_batlers
  end

  def battle_men_array
    (0...choice_batlers).step(1) do |line|
      array << sum(mens[line],
                   all_batlers.length).unshift(all_batlers[line])
    end
    array
  end
end
