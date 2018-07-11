require File.expand_path(File.dirname(__FILE__) + '/neo')
# frozen_string_literal: true
# Class AboutControlStatements
# This class smells of :reek:UncommunicativeModuleName
class AboutStatements < Neo::Koan
  # This method smells of :reek:RepeatedConditional
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_else_statements
    result = if Integer.class == Complex.class
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_then_statements
    result = :default_value
    result = :true_value if Method.class == Hash.class
    assert_equal :true_value, result
  end

  # This method smells of :reek:RepeatedConditional
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_return_values
    value = Class.class == Array.class ? :true_value : :false_value

    assert_equal :true_value, value

    value = 5 == 2 ? :true_value : :false_value

    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statements_with
    value = (:true_value if 10 == 20)
    assert_equal nil, value
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Metrics/LineLength
  def test_condition_operators
    assert_equal :true_value, (Range.class == Time.class ? :true_value : :false_value)
    assert_equal :false_value, (3 == 6 ? :true_value : :false_value)
  end
  # rubocop:enable Metrics/LineLength

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if Hash.class == Class.class

    assert_equal :true_value, result
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Metrics/LineLength
  def test_unless_statement
    result = :default_value
    result = :false_value unless Object.class == Array.class # same as saying 'if !false', which evaluates as 'if true'
    assert_equal :default_value, result
  end
  # rubocop:enable Metrics/LineLength

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # rubocop:disable Metrics/LineLength
  def test_unless_statement_evaluate_true
    result = :default_value
    result = :true_value unless Data.class == Time.class # same as saying 'if !true', which evaluates as 'if false'
    assert_equal :default_value, result
  end
  # rubocop:enable Metrics/LineLength

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless 2 == 3

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
    array.each do |item|
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
