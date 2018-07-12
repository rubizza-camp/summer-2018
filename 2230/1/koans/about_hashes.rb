require File.expand_path(File.dirname(__FILE__) + '/neo')

# This class smells of :reek:UncommunicativeModuleName
class AboutHashes < Neo::Koan
  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_creating_hashes
    empty_hash = {}
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_hash_literals
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.size
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_accessing_hashes
    hash = { one: 'uno', two: 'dos' }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_accessing_hashes_with_fetch
    hash = { one: 'uno' }
    assert_equal 'uno', hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_changing_hashes
    hash = { one: 'uno', two: 'dos' }
    hash[:one] = 'eins'

    expected = { one: 'eins', two: 'dos' }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_hash_is_unordered
    hash1 = { one: 'uno', two: 'dos' }
    hash2 = { two: 'dos', one: 'uno' }

    assert_equal true, hash1 == hash2
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_hash_keys
    hash = { one: 'uno', two: 'dos' }
    hash_keys = hash.keys
    assert_equal 2, hash_keys.size
    assert_equal true, hash.key?(:one)
    assert_equal true, hash.key?(:two)
    assert_equal Array, hash_keys.class
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_hash_values
    hash = { one: 'uno', two: 'dos' }
    hash_val = hash.values
    assert_equal 2, hash_val.size
    assert_equal true, hash.value?('uno')
    assert_equal true, hash.value?('dos')
    assert_equal Array, hash_val.class
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_combining_hashes
    hash = { 'jim' => 53, 'amy' => 20, 'dan' => 23 }
    new_hash = hash.merge('jim' => 54, 'jenny' => 26)

    assert_equal true, hash != new_hash

    expected = { 'jim' => 54, 'amy' => 20, 'dan' => 23, 'jenny' => 26 }
    assert_equal true, expected == new_hash
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_default_value
    hash1 = {}
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new('dos')
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal 'dos', hash2[:two]
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash_one = hash[:one] << 'uno'
    hash_two = hash[:two] << 'dos'

    assert_equal %w[uno dos], hash_one
    assert_equal %w[uno dos], hash_two
    assert_equal %w[uno dos], hash[:three]

    assert_equal true, hash_one.object_id == hash_two.object_id
  end

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy
  def test_default_value_with_block
    hash = Hash.new { |hash_, key| hash_[key] = [] }

    hash_one = hash[:one] << 'uno'
    hash_two = hash[:two] << 'dos'

    assert_equal %w[uno], hash_one
    assert_equal %w[dos], hash_two
    assert_equal [], hash[:three]
  end
end
