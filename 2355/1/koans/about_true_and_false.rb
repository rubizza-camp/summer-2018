require File.expand_path(File.dirname(__FILE__) + '/neo')

# Class docs
# This class smells of :reek:UncommunicativeModuleName
class AboutTrueAndFalse < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:ControlParameter
  def truth_value(condition)
    if condition
      :true_stuff
    else
      :false_stuff
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_true_is_treated_as_true
    assert_equal :true_stuff, truth_value(true)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_false_is_treated_as_false
    assert_equal :false_stuff, truth_value(false)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_nil_is_treated_as_false_too
    assert_equal :false_stuff, truth_value(nil)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_everything_else_is_treated_as_true
    assert_equal :true_stuff, truth_value(1)
    assert_equal :true_stuff, truth_value(0)
    assert_equal :true_stuff, truth_value([])
    assert_equal :true_stuff, truth_value({})
    assert_equal :true_stuff, truth_value('Strings')
    assert_equal :true_stuff, truth_value('')
  end
end
