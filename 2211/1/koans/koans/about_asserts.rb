# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/neo')
class AboutAsserts < Neo::Koan
  # We shall contemplate truth by testing reality, via asserts.
  # rubocop: disable Lint/LiteralAsCondition
  # rubocop: disable Style/GuardClause
  def test_assert_truth
    #--
    assert true
    if false
      #++
      assert false
      #--
    end
    #++
  end
  # rubocop: enable Lint/LiteralAsCondition
  # rubocop: enable Style/GuardClause

  # Enlightenment may be more easily achieved with appropriate
  # messages.
  # rubocop: disable Lint/LiteralAsCondition
  # rubocop: disable Style/GuardClause
  def test_assert_with_message
    #--
    assert true, 'This should be true -- Please fix this'
    if false
      #++
      assert false, 'This should be true -- Please fix this'
      #--
    end
    #++
  end
  # rubocop: enable Lint/LiteralAsCondition
  # rubocop: enable Style/GuardClause

  # To understand reality, we must compare our expectations against
  # reality.
  def test_assert_equality
    expected_value = 2
    actual_value = 1 + 1

    assert expected_value == actual_value
  end

  # Some ways of asserting equality are better than others.
  def test_a_better_way_of_asserting_equality
    expected_value = 2
    actual_value = 1 + 1

    assert_equal expected_value, actual_value
  end

  # Sometimes we will ask you to fill in the values
  def test_fill_in_values
    assert_equal 2, 1 + 1
  end
end
