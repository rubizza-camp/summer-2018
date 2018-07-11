require File.expand_path(File.dirname(__FILE__) + '/neo')

# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Lint/Void
# rubocop:disable Lint/UnreachableCode
# rubocop:disable Style/AccessModifierDeclarations
# Def Global
# This method smells of :reek:UncommunicativeParameterName
# This method smells of :reek:UtilityFunction
def my_global_method(aaaa, bbbb)
  aaaa + bbbb
end

# Class docs
# This class smells of :reek:UncommunicativeModuleName
# This class smells of :reek:TooManyMethods
class AboutMethods < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_global_methods
    assert_equal 5, my_global_method(2, 3)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_global_methods_without_parentheses
    result = my_global_method 2, 3
    assert_equal 5, result
  end

  # (NOTE: We are Using eval below because the example code is
  # considered to be syntactically invalid).
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_sometimes_missing_parentheses_are_ambiguous
    assert_equal 5, my_global_method(2, 3) # ENABLE CHECK
    #
    # Ruby doesn't know if you mean:
    #
    #   assert_equal(5, my_global_method(2), 3)
    # or
    #   assert_equal(5, my_global_method(2, 3))
    #
    # Rewrite the eval string to continue.
    #
  end

  # NOTE: wrong number of arguments is not a SYNTAX error, but a
  # runtime error.
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:DuplicateMethodCall
  def test_calling_global_methods_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      my_global_method
    end
    assert_match(/./, exception.message)

    exception = assert_raise(ArgumentError) do
      my_global_method(1, 2, 3)
    end
    assert_match(/./, exception.message)
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_with_defaults(uno, des = :default_value)
    [uno, des]
  end

  def test_calling_with_default_values
    assert_equal [1, :default_value], method_with_defaults(1)
    assert_equal [1, 2], method_with_defaults(1, 2)
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_with_var_args(*args)
    args
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_with_variable_arguments
    assert_equal Array, method_with_var_args.class
    assert_equal [], method_with_var_args
    assert_equal %i[one], method_with_var_args(:one)
    assert_equal %i[one two], method_with_var_args(:one, :two)
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_with_explicit_return
    :a_non_return_value
    return :return_value
    :another_non_return_value
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_method_with_explicit_return
    assert_equal :return_value, method_with_explicit_return
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def method_without_explicit_return
    :a_non_return_value
    :return_value
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_method_without_explicit_return
    assert_equal :return_value, method_without_explicit_return
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:UtilityFunction
  def my_method_in_the_same_class(uno, des)
    uno * des
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_methods_in_same_class
    assert_equal 12, my_method_in_the_same_class(3, 4)
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_methods_in_same_class_with_explicit_receiver
    assert_equal 12, my_method_in_the_same_class(3, 4)
  end

  # ------------------------------------------------------------------

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def my_private_method
    'a secret'
  end
  private :my_private_method

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_private_methods_without_receiver
    assert_equal 'a secret', my_private_method
  end

  # rubocop:disable Style/RedundantSelf
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_private_methods_with_an_explicit_receiver
    exception = assert_raise(NoMethodError) do
      self.my_private_method
    end
    assert_match(/my_private_method/, exception.message)
  end
  # rubocop:enable Style/RedundantSelf

  # ------------------------------------------------------------------

  # Class Dog
  # This class smells of :reek:UncommunicativeModuleName
  class Dog
    def name
      'Fido'
    end

    private

    def tail
      'tail'
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_methods_in_other_objects_require_explicit_receiver
    rover = Dog.new
    assert_equal 'Fido', rover.name
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_calling_private_methods_in_other_objects
    rover = Dog.new
    assert_raise(NoMethodError) do
      rover.tail
    end
  end
end
# rubocop:enable Lint/Void
# rubocop:enable Lint/UnreachableCode
# rubocop:enable Style/AccessModifierDeclarations
# rubocop:enable Lint/UnneededCopDisableDirective
