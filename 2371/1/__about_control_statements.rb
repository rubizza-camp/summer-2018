require File.expand_path(File.dirname(__FILE__) + '/neo')
# :nodoc:
# rubocop : disable ClassLength
class AboutControlStatemets < Neo::Koan
  # rubocop : enable ClassLength
  def test_if_then_else_statements
    # rubocop : disable LiteralAsCondition
    result = true ? :true_value : :false_value
    # rubocop : enable LiteralAsCondition
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    # rubocop : disable LiteralAsCondition
    result = :true_value if true
    # rubocop : enable LiteralAsCondition
    assert_equal :true_value, result
  end

  # rubocop : disable LiteralAsCondition, MethodLength
  def test_if_statements_values
    value = if true
              :true_value
            else
              :false_value
            end
    # rubocop : enable LiteralAsCondition, MethodLength
    assert_equal :true_value, value

    # rubocop : disable LiteralAsCondition
    value = if false
              :true_value
            else
              :false_value
            end
    # rubocop : enable LiteralAsCondition
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  def test_if_statements_with_no_else_with_false_condition_return_value
    # rubocop : disable LiteralAsCondition
    value = (:true_value if false)
    # rubocop : enable LiteralAsCondition
    assert_equal nil, value
  end

  def test_condition_operators
    # rubocop : disable LiteralAsCondition
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
    # rubocop : enable LiteralAsCondition
  end

  def test_if_statement_modifiers
    result = :default_value
    # rubocop : disable LiteralAsCondition
    result = :true_value if true
    # rubocop : enable LiteralAsCondition

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    # same as saying 'if !false', which evaluates as 'if true'
    # rubocop : disable LiteralAsCondition
    result = :false_value unless false
    # rubocop : enable LiteralAsCondition
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    # same as saying 'if !true', which evaluates as 'if false'
    # rubocop : disable LiteralAsCondition
    result = :true_value unless true
    # rubocop : enable LiteralAsCondition
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    # rubocop : disable LiteralAsCondition
    result = :false_value unless false
    # rubocop : enable LiteralAsCondition

    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

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

  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
               break i if i.even?
               i += 1
             end

    assert_equal 2, result
  end

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

  def test_for_statement
    array = %w[fish and chips]
    result = []
    array.each do |item|
      result << item.upcase
    end
    assert_equal %w[FISH AND CHIPS], result
  end

  def test_times_statement
    sum = 0
    10.times do
      sum += 1
    end
    assert_equal 10, sum
  end
end
