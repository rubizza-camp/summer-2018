require File.expand_path(File.dirname(__FILE__) + '/neo')
# frozen_string_literal: true
# Class AboutKeywordArguments
# This class smells of :reek:UncommunicativeModuleName
class AboutKeywordArguments < Neo::Koan
  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, 'two'], method_with_keyword_arguments
    assert_equal %w[one two], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end
  # rubocop:disable Metrics/LineLength
  # rubocop:disable Layout/EmptyLineBetweenDefs
  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end
  # rubocop:enable Metrics/LineLength
  # rubocop:enable Layout/EmptyLineBetweenDefs

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    assert_match(/(given 0, expected 1)/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments alwl to the caller
end
