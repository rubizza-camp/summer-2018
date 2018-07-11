require File.expand_path(File.dirname(__FILE__) + '/neo')
# rubocop: disable Methrics/ClassLength
# This class smells of :reek:UncommunicativeModuleName
# :reek:RepeatedConditional
class AboutControlStatements < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_else_statements
    # rubocop: disable Lint/LiteralAsCondition
    result = if true
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
    # rubocop: enable Lint/LiteralAsCondition
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_statements
    result = :default_value
    # rubocop: disable Lint/LiteralAsCondition
    result = :true_value if true
    assert_equal :true_value, result
    # rubocop: enable Lint/LiteralAsCondition
  end

  # rubocop: disable Metrics/MethodLength
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_return_values
    # rubocop: disable Lint/LiteralAsCondition
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
    # rubocop: enable Lint/LiteralAsCondition

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end
  # rubocop: enable Metrics/MethodLength

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_with_no_else_with_false_condition_return_value
    # rubocop: disable Lint/LiteralAsCondition
    value = (:true_value if false)
    assert_equal nil, value
    # rubocop: enable Lint/LiteralAsCondition
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_condition_operators
    # rubocop: disable Lint/LiteralAsCondition
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
    # rubocop: enable Lint/LiteralAsCondition
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statement_modifiers
    result = :default_value
    # rubocop: disable Lint/LiteralAsCondition
    result = :true_value if true
    # rubocop: enable Lint/LiteralAsCondition
    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement
    result = :default_value
    # rubocop: disable Lint/LiteralAsCondition
    result = :false_value unless false # same as saying 'if !false', which evaluates as 'if true'
    # rubocop: enable Lint/LiteralAsCondition
    assert_equal :false_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement_evaluate_true
    result = :default_value
    # rubocop: disable Lint/LiteralAsCondition
    result = :true_value unless true # same as saying 'if !true', which evaluates as 'if false'
    # rubocop: enable Lint/LiteralAsCondition
    assert_equal :default_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement_modifier
    result = :default_value
    # rubocop: disable Lint/LiteralAsCondition
    result = :false_value unless false
    # rubocop: enable Lint/LiteralAsCondition

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
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_break_statement
    i = 1
    result = 1
    loop do
      break unless i <= 10
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
               break i if i.even?
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
      next if i.even?
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
    # rubocop: disable Style/For
    for item in array
      result << item.upcase
    end
    # rubocop: enable Style/For
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
# rubocop: enable Methrics/ClassLength
