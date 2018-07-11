require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/ConditionalAssignment
# rubocop:disable Style/IfUnlessModifier
# rubocop:disable Style/SelfAssignment
# rubocop:disable Style/NumericLiterals
# rubocop:disable Style/InfiniteLoop
# rubocop:disable Style/EvenOdd
# rubocop:disable Style/NumericPredicate
# rubocop:disable Style/For
# rubocop:disable Lint/LiteralAsCondition
# rubocop:disable Layout/IndentationWidth
# rubocop:disable Layout/EndAlignment
# Class docs
# This class smells of :reek:UncommunicativeModuleName
# This class smells of :reek:RepeatedConditional
class AboutControlStatements < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_else_statements
    if true
      result = :true_value
    else
      result = :false_value
    end

    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_statements
    result = :default_value
    if true
      result = :true_value
    end
    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = if false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    assert_equal nil, value
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement
    result = :default_value
    unless false
      result = :false_value
    end
    assert_equal :false_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement_evaluate_true
    result = :default_value
    unless true
      result = :true_value
    end
    assert_equal :default_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result = result * i
      i += 1
    end
    assert_equal 3628800, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_break_statement
    i = 1
    result = 1
    while true
      break unless i <= 10
      result = result * i
      i += 1
    end
    assert_equal 3628800, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
      break i if i % 2 == 0
      i += 1
    end

    assert_equal 2, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if (i % 2) == 0
      result << i
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_for_statement
    array = %w[fish and chips]
    result = []
    for item in array
      result << item.upcase
    end
    assert_equal %w[FISH AND CHIPS], result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_times_statement
    sum = 0
    10.times do
      sum += 1
    end
    assert_equal 10, sum
  end
end
# rubocop:enable Metrics/ClassLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/ConditionalAssignment
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Style/SelfAssignment
# rubocop:enable Style/NumericLiterals
# rubocop:enable Style/InfiniteLoop
# rubocop:enable Style/EvenOdd
# rubocop:enable Style/NumericPredicate
# rubocop:enable Style/For
# rubocop:enable Lint/LiteralAsCondition
# rubocop:enable Layout/IndentationWidth
# rubocop:enable Layout/EndAlignment
