require File.expand_path(File.dirname(__FILE__) + '/neo')
# AboutKeywordArguments
# This class smells of :reek:UncommunicativeModuleName
class AboutKeywordArguments < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_with_keyword_args(one: 1, two: 'two')
    [one, two]
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_keyword_arguments
    assert_equal Array, method_with_keyword_args.class
    assert_equal [1, 'two'], method_with_keyword_args
    assert_equal %w[one two], method_with_keyword_args(one: 'one')
    assert_equal [1, 2], method_with_keyword_args(two: 2)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_with_keyword_args_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      method_with_keyword_args_with_mandatory_argument
    end
    assert_match(/wrong number of arguments/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments always have a default value,
  # making them optional to the caller
end
