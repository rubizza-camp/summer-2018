require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:UtilityFunction
# :reek:UncommunicativeParameterName
# :reek:TooManyStatements
# rubocop: disable Naming/UncommunicativeMethodParamName
def my_global_method(a, b)
  a + b
end
# rubocop: enable Naming/UncommunicativeMethodParamName

# :reek:TooManyMethods
# rubocop: disable Style/AccessModifierDeclarations
class AboutMethods < Neo::Koan
  def test_calling_global_methods
    assert_equal 5, my_global_method(2, 3)
  end

  def test_calling_global_methods_without_parentheses
    result = my_global_method 2, 3
    assert_equal 5, result
  end

  # (NOTE: We are Using eval below because the example code is
  # considered to be syntactically invalid).
  # rubocop: disable Style/EvalWithLocation
  # rubocop: disable Style/GuardClause
  # rubocop: disable Lint/LiteralAsCondition
  def test_sometimes_missing_parentheses_are_ambiguous
    #--
    eval 'assert_equal 5, my_global_method(2, 3)'
    if false
      #++
      eval 'assert_equal 5, my_global_method 2, 3'
      #--
    end
    #++
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
  # rubocop: enable Style/EvalWithLocation
  # rubocop: enable Style/GuardClause
  # rubocop: enable Lint/LiteralAsCondition

  # NOTE: wrong number of arguments is not a SYNTAX error, but a
  # runtime error.
  # :reek:TooManyStatements
  def test_calling_global_methods_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      my_global_method
    end
    #--
    pattern = 'wrong (number|#) of arguments'
    #++
    assert_match(/#{__(pattern)}/, exception.message)

    exception = assert_raise(ArgumentError) do
      my_global_method(1, 2, 3)
    end
    assert_match(/#{pattern}/, exception.message)
  end

  # ------------------------------------------------------------------

  # :reek:UncommunicativeParameterName
  # rubocop: disable Naming/UncommunicativeMethodParamName
  def method_with_defaults(a, b = :default_value)
    [a, b]
  end
  # rubocop: enable Naming/UncommunicativeMethodParamName

  def test_calling_with_default_values
    assert_equal [1, :default_value], method_with_defaults(1)
    assert_equal [1, 2], method_with_defaults(1, 2)
  end

  # ------------------------------------------------------------------

  def method_with_var_args(*args)
    args
  end

  def test_calling_with_variable_arguments
    assert_equal Array, method_with_var_args.class
    assert_equal [], method_with_var_args
    assert_equal %i[one], method_with_var_args(:one)
    assert_equal %i[one two], method_with_var_args(:one, :two)
  end

  # ------------------------------------------------------------------

  # rubocop: disable Lint/Void
  # rubocop: disable Lint/UnreachableCode
  # rubocop: disable Lint/UnneededCopDisableDirective
  def method_with_explicit_return
    :a_non_return_value
    return :return_value
    :another_non_return_value
  end
  # rubocop: enable Lint/UnreachableCode
  # rubocop: ensable Lint/Void
  # rubocop: enable Lint/UnneededCopDisableDirective

  def test_method_with_explicit_return
    assert_equal :return_value, method_with_explicit_return
  end

  # ------------------------------------------------------------------

  # rubocop: disable Lint/UnneededCopDisableDirective
  # rubocop: disable Lint/Void
  def method_without_explicit_return
    :a_non_return_value
    :return_value
  end
  # rubocop: enable Lint/Void
  # rubocop: enable Lint/UnneededCopDisableDirective

  def test_method_without_explicit_return
    assert_equal :return_value, method_without_explicit_return
  end

  # ------------------------------------------------------------------

  # :reek:UtilityFunction
  # :reek:UncommunicativeParameterName
  # rubocop: disable Naming/UncommunicativeMethodParamName
  def my_method_in_the_same_class(a, b)
    a * b
  end
  # rubocop: enable Naming/UncommunicativeMethodParamName

  def test_calling_methods_in_same_class
    assert_equal 12, my_method_in_the_same_class(3, 4)
  end

  # rubocop: disable Style/RedundantSelf
  def test_calling_methods_in_same_class_with_explicit_receiver
    assert_equal 12, self.my_method_in_the_same_class(3, 4)
  end
  # rubocop: enable Style/RedundantSelf

  # ------------------------------------------------------------------

  def my_private_method
    'a secret'
  end
  private :my_private_method

  def test_calling_private_methods_without_receiver
    assert_equal 'a secret', my_private_method
  end

  # rubocop: disable Lint/AmbiguousRegexpLiteral/
  # rubocop: disable Style/RedundantSelf
  def test_calling_private_methods_with_an_explicit_receiver
    exception = assert_raise(NoMethodError) do
      self.my_private_method
    end
    assert_match /#{"method `my_private_method'"}/, exception.message
  end
  # rubocop: enable Style/RedundantSelf
  # rubocop: enable Lint/AmbiguousRegexpLiteral/

  # ------------------------------------------------------------------

  class Dog
    def name
      'Fido'
    end

    private

    def tail
      'tail'
    end
  end

  def test_calling_methods_in_other_objects_require_explicit_receiver
    rover = Dog.new
    assert_equal 'Fido', rover.name
  end

  def test_calling_private_methods_in_other_objects
    rover = Dog.new
    assert_raise(NoMethodError) do
      rover.tail
    end
  end
end
# rubocop: enable Style/AccessModifierDeclarations
