require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:IrresponsibleModule
# :reek:InstanceVariableAssumption
# :reek:TooManyMethods
class AboutClasses < Neo::Koan
  # :reek:IrresponsibleModule
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:UncommunicativeModuleName
  class Dog2
    # rubocop:disable Naming/AccessorMethodName
    def set_name(a_name)
      @name = a_name
    end
    # rubocop:enable Naming/AccessorMethodName
  end

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    assert_equal [], fido.instance_variables

    fido.set_name('Fido')
    assert_equal %i[@name], fido.instance_variables
  end

  # :reek:TooManyStatements
  # rubocop:disable Style/EvalWithLocation
  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.set_name('Fido')

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval 'fido.@name'
      # NOTE: Using eval because the above line is a syntax error.
    end
    # rubocop:enable Style/EvalWithLocation
  end

  # :reek:FeatureEnvy
  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dog2.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_variable_get('@name')
  end

  # rubocop:disable Style/EvalWithLocation
  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dog2.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.instance_eval('@name') # string version
    assert_equal 'Fido', (fido.instance_eval { @name }) # block version
  end
  # rubocop:enable Style/EvalWithLocation

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:InstanceVariableAssumption
  # :reek:UncommunicativeModuleName
  class Dog3
    # rubocop:disable Naming/AccessorMethodName
    def set_name(a_name)
      @name = a_name
    end
    # rubocop:enable Naming/AccessorMethodName
    # rubocop:disable Layout/EmptyLineBetweenDefs
    # rubocop:disable Style/TrivialAccessors
    def name
      @name
    end
    # rubocop:enable Layout/EmptyLineBetweenDefs
    # rubocop:enable Style/TrivialAccessors
  end

  # :reek:FeatureEnvy
  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Dog3.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:UncommunicativeModuleName
  class Dog4
    attr_reader :name
    # rubocop:disable Naming/AccessorMethodName
    def set_name(a_name)
      @name = a_name
    end
    # rubocop:enable Naming/AccessorMethodName
  end

  # :reek:FeatureEnvy
  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.set_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:Attribute
  # :reek:UncommunicativeModuleName
  class Dog5
    attr_accessor :name
  end

  # :reek:FeatureEnvy
  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Dog5.new

    fido.name = 'Fido'
    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  # :reek:IrresponsibleModule
  # :reek:UncommunicativeModuleName
  class Dog6
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Dog6.new('Fido')
    assert_equal 'Fido', fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
    fido = Dog6.new('Fido')
    rover = Dog6.new('Rover')

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  # :reek:UncommunicativeModuleName
  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end
    # rubocop:disable Naming/AccessorMethodName
    # rubocop:disable Layout/EmptyLineBetweenDefs
    def get_self
      self
    end
    # rubocop:enable Naming/AccessorMethodName
    # rubocop:enable Layout/EmptyLineBetweenDefs

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Dog7.new('Fido')

    fidos_self = fido.get_self
    assert_equal fido.get_self, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Dog7.new('Fido')
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Dog7.new('Fido')
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Dog7.new('Fido')
    assert_equal '<Dog named \'Fido\'>', fido.inspect
  end

  # rubocop:disable Style/StringLiterals
  def test_all_objects_support_to_s_and_inspect
    array = [1, 2, 3]

    assert_equal '[1, 2, 3]', array.to_s
    assert_equal '[1, 2, 3]', array.inspect

    assert_equal 'STRING', 'STRING'.to_s
    assert_equal "\"STRING\"", 'STRING'.inspect
  end
  # rubocop:enable Style/StringLiterals
end
