require File.expand_path(File.dirname(__FILE__) + '/neo')

# Implement a DiceSet Class here:
#
class DiceSet
  attr_reader :meanings

  def roll(size)
    @meanings = Array.new(size) { rand(1..6) }
  end
end

# This class smells of :reek:UncommunicativeModuleName
class AboutDiceProject < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_can_create_a_dice_set
    dice = DiceSet.new
    assert_not_nil dice
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_rolling_the_dice_returns_a_set_of_integers_between_1_and_6
    dice = DiceSet.new

    dice.roll(5)
    assert dice.meanings.is_a?(Array), 'should be an array'
    assert_equal 5, dice.meanings.size
    dice.meanings.each do |value|
      assert value >= 1 && value <= 6, "value #{value} must be between 1 and 6"
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_dice_values_do_not_change_unless_explicitly_rolled
    dice = DiceSet.new
    dice.roll(5)
    first_time = dice.meanings
    second_time = dice.meanings
    assert_equal first_time, second_time
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_dice_values_should_change_between_rolls
    dice = DiceSet.new

    dice.roll(5)
    first_time = dice.meanings

    dice.roll(5)
    second_time = dice.meanings

    assert_not_equal first_time, second_time,
                     'Two rolls should not be equal'

    # THINK ABOUT IT:
    #
    # If the rolls are random, then it is possible (although not
    # likely) that two consecutive rolls are equal.  What would be a
    # better way to test this?
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_you_can_roll_different_numbers_of_dice
    dice = DiceSet.new

    dice.roll(3)
    assert_equal 3, dice.meanings.size

    dice.roll(1)
    assert_equal 1, dice.meanings.size
  end
end
