require File.expand_path(File.dirname(__FILE__) + '/neo')

# This class smells of :reek:UncommunicativeModuleName
# :reek:ManualDispatch
# :reek:UtilityFunction
class AboutToStr < Neo::Koan
  class CanNotBeTreatedAsString
    def to_s
      'non-string-like'
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_to_s_returns_a_string_representation
    not_like_a_string = CanNotBeTreatedAsString.new
    assert_equal 'non-string-like', not_like_a_string.to_s
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_normally_objects_cannot_be_used_where_strings_are_expected
    assert_raise(TypeError) do
      File.exist?(CanNotBeTreatedAsString.new)
    end
  end

  # ------------------------------------------------------------------

  class CanBeTreatedAsString
    def to_s
      'string-like'
    end

    def to_str
      to_s
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_to_str_also_returns_a_string_representation
    like_a_string = CanBeTreatedAsString.new
    assert_equal 'string-like', like_a_string.to_str
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_to_str_allows_objects_to_be_treated_as_strings
    assert_equal false, File.exist?(CanBeTreatedAsString.new)
  end

  # ------------------------------------------------------------------

  def acts_like_a_string?(string)
    string = string.to_str if string.respond_to?(:to_str)
    string.is_a?(String)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_user_defined_code_can_check_for_to_str
    assert_equal false, acts_like_a_string?(CanNotBeTreatedAsString.new)
    assert_equal true,  acts_like_a_string?(CanBeTreatedAsString.new)
  end
end
