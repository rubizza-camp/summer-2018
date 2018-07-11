require File.expand_path(File.dirname(__FILE__) + '/neo')

# This class smells of :reek:UncommunicativeModuleName
class AboutArrayAssignment < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_non_parallel_assignment
    names = %w[John Smith]
    assert_equal %w[John Smith], names
  end

  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignments
    first_name = 'John'
    last_name = 'Smith'
    assert_equal 'John', first_name
    assert_equal 'Smith', last_name
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignments_with_extra_values
    first_name, last_name = %w[John Smith III]
    assert_equal 'John', first_name
    assert_equal 'Smith', last_name
  end

  # if it was first_name, last_name, other_name, then other_name would be "III"

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = %w[John Smith III]
    assert_equal 'John', first_name
    assert_equal %w[Smith III], last_name
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ['Cher']
    assert_equal 'Cher', first_name
    assert_equal nil, last_name
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignments_with_subarrays
    first_name = %w[Willie Rae]
    last_name = 'Johnson'
    assert_equal %w[Willie Rae], first_name
    assert_equal 'Johnson', last_name
  end

  # remember the assignment order defined on the left matches the array
  # on the right

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_parallel_assignment_with_one_variable
    first_name, = %w[John Smith]
    assert_equal 'John', first_name
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_swapping_with_parallel_assignment
    first_name = 'Roy'
    last_name = 'Rob'
    first_name, last_name = last_name, first_name
    assert_equal 'Rob', first_name
    assert_equal 'Roy', last_name
  end
end
