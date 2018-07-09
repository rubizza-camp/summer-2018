require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Lint/LiteralAsCondition
# rubocop:disable Style/IfUnlessModifier
# adfa asdfa asdf
# :reek:RepeatedConditional
class AboutControlStatements < Neo::Koan
  def test_if_then_else_statements
    result = if true
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    if true
      result = :true_value
    end
    assert_equal :true_value, result
  end

  # :reek:RepeatedConditional
  def test_if_statements_return_values
    value = if true
              :true_value
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

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    assert_equal nil, value
  end

  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end
end

# asdf asdf asdf
class AboutControlStatements < Neo::Koan
  def test_unless_statement
    result = :default_value
    unless false # same as saying 'if !false', which evaluates as 'if true'
      result = :false_value
    end
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    unless true # same as saying 'if !true', which evaluates as 'if false'
      result = :true_value
    end
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  # :reek:FeatureEnvy
  def test_while_statement
    ins = 1
    result = 1
    while ins <= 10
      result *= ins
      ins += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:TooManyStatements
  def test_break_statement
    ins = 1
    result = 1
    loop do
      break unless ins <= 10
      result *= ins
      ins += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:FeatureEnvy
  def test_break_statement_returns_values
    ins = 1
    result = while ins <= 10
               break ins if (ins % 2).zero?
               ins += 1
             end

    assert_equal 2, result
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def test_next_statement
    ins = 0
    result = []
    while ins < 10
      ins += 1
      next if (ins % 2).zero?
      result << ins
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
  # rubocop:enable Lint/LiteralAsCondition
  # rubocop:enable Style/IfUnlessModifier
end
