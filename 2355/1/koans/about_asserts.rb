# -*- ruby -*-

# Class docs
# This class smells of :reek:UncommunicativeModuleName
require File.expand_path(File.dirname(__FILE__) + '/neo')

# Class AboutAsserts
# This class smells of :reek:UncommunicativeModuleName
class AboutAsserts < Neo::Koan
  # We shall contemplate truth by testing reality, via asserts.
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_assert_truth
    assert true # This should be true
  end

  # Enlightenment may be more easily achieved with appropriate
  # messages.
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_assert_with_message
    assert true, 'This should be true -- Please fix this'
  end

  # To understand reality, we must compare our expectations against
  # reality.
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_assert_equality
    expected_value = 2
    actual_value = 1 + 1

    assert expected_value == actual_value
  end

  # Some ways of asserting equality are better than others.
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_a_better_way_of_asserting_equality
    expected_value = 2
    actual_value = 1 + 1

    assert_equal expected_value, actual_value
  end

  # Sometimes we will ask you to fill in the values
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_fill_in_values
    assert_equal 2, 1 + 1
  end
end
