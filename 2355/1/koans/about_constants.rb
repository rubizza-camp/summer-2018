require File.expand_path(File.dirname(__FILE__) + '/neo')

C = 'top level'.freeze

# rubocop:disable Style/ClassAndModuleChildren

# Class docs
# This class smells of :reek:UncommunicativeModuleName
class AboutConstants < Neo::Koan
  C = 'nested'.freeze

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_nested_constants_may_also_be_referenced_with_relative_paths
    assert_equal 'nested', C
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_top_level_constants_are_referenced_by_double_colons
    assert_equal 'top level', ::C
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_nested_constants_are_referenced_by_their_complete_path
    assert_equal 'nested', AboutConstants::C
    assert_equal 'nested', ::AboutConstants::C
  end

  # ------------------------------------------------------------------

  # Class Animal
  # This class smells of :reek:UncommunicativeModuleName
  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    # Class NestedAnimal
    class NestedAnimal
      def legs_in_nested_animal
        LEGS
      end
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_nested_classes_inherit_constants_from_enclosing_classes
    assert_equal 4, Animal::NestedAnimal.new.legs_in_nested_animal
  end

  # ------------------------------------------------------------------

  # Class Reptile
  # This class smells of :reek:UncommunicativeModuleName
  class Reptile < Animal
    def legs_in_reptile
      LEGS
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_subclasses_inherit_constants_from_parent_classes
    assert_equal 4, Reptile.new.legs_in_reptile
  end

  # ------------------------------------------------------------------

  # Class MyAnimals
  class MyAnimals
    LEGS = 2

    # Class Bird
    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_who_wins_with_both_nested_and_inherited_constants
    assert_equal 2, MyAnimals::Bird.new.legs_in_bird
  end

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?

  # ------------------------------------------------------------------

  # This class smells of :reek:UncommunicativeModuleName
  # Class MyAnimals(one more)
  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_who_wins_with_explicit_scoping_on_class_definition
    assert_equal 4, MyAnimals::Oyster.new.legs_in_oyster
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
end
# rubocop:enable Style/ClassAndModuleChildren
