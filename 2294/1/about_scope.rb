require File.expand_path(File.dirname(__FILE__) + '/neo')

# This class smells of :reek:UncommunicativeModuleName
class AboutScope < Neo::Koan
  module Jims
    class Dog
      def identify
        :jims_dog
      end
    end
  end

  module Joes
    class Dog
      def identify
        :joes_dog
      end
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_dog_is_not_available_in_the_current_scope
    assert_raise(NameError) do
      Dog.new
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_you_can_reference_nested_classes_using_the_scope_operator
    fido = Jims::Dog.new
    rover = Joes::Dog.new
    assert_equal :jims_dog, fido.identify
    assert_equal :joes_dog, rover.identify

    assert_equal true, fido.class != rover.class
    assert_equal true, Jims::Dog != Joes::Dog
  end

  # ------------------------------------------------------------------

  class String
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_bare_bones_class_names_assume_the_current_scope
    assert_equal true, AboutScope::String == String
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_nested_string_is_not_the_same_as_the_system_string
    assert_equal false, String == 'HI'.class
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_use_the_prefix_scope_operator_to_force_the_global_scope
    assert_equal true, ::String == 'HI'.class
  end

  # ------------------------------------------------------------------

  PI = 3.1416

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_constants_are_defined_with_an_initial_uppercase_letter
    assert_equal 3.1416, PI
  end

  # ------------------------------------------------------------------

  MyString = ::String

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_class_names_are_just_constants
    assert_equal true, MyString == ::String
    assert_equal true, MyString == 'HI'.class
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_constants_can_be_looked_up_explicitly
    assert_equal true, PI == AboutScope.const_get('PI')
    assert_equal true, MyString == AboutScope.const_get('MyString')
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_you_can_get_a_list_of_constants_for_any_class_or_module
    assert_equal %i[Dog], Jims.constants
    assert Object.constants.size > 123
  end
end
