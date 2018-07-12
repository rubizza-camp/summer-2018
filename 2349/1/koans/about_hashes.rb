require File.expand_path(File.dirname(__FILE__) + '/neo')

# This class smells of :reek:UncommunicativeModuleName
class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = {}
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { one: 'uno', two: 'dos' }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

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
    hashka = { one: 'uno', two: 'dos' }
    hashku = { two: 'dos', one: 'uno' }

    assert_equal true, hashka == hashku
  end

  #:reek:DuplicateMethodCall
  def test_hash_keys
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.value?(:one)
    assert_equal true, hash.keys.value?(:two)
    assert_equal Array, hash.keys.class
  end

  #:reek:DuplicateMethodCall
  def test_hash_values
    hash = { one: 'uno', two: 'dos' }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.value?('uno')
    assert_equal true, hash.values.value?('dos')
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { 'jim' => 53, 'amy' => 20, 'dan' => 23 }
    new_hash = hash.merge('jim' => 54, 'jenny' => 26)

    assert_equal true, hash != new_hash

    expected = { 'jim' => 54, 'amy' => 20, 'dan' => 23, 'jenny' => 26 }
    assert_equal true, expected == new_hash
  end

  #:reek:TooManyStatements
  def test_default_value
    hashbl = {}
    hashbl[:one] = 1

    assert_equal 1, hashbl[:one]
    assert_equal nil, hashbl[:two]

    hashz = Hash.new('dos')
    hashz[:one] = 1

    assert_equal 1, hashz[:one]
    assert_equal 'dos', hashz[:two]
  end

  # rubocop:disable Metrics/AbcSize
  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal %w[uno dos], hash[:one]
    assert_equal %w[uno dos], hash[:two]
    assert_equal %w[uno dos], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end
  # rubocop:enable Metrics/AbcSize

  # This method smells of :reek:UncommunicativeMethodName
  # This method smells of :reek:UncommunicativeVariableName
  # This method smells of :reek:TooManyStatements
  # This method smells of :reek:FeatureEnvy

  def test_default_value_with_block
    hash = Hash.new { |hash_, key| hash_[key] = [] }

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal %w[uno], hash[:one]
    assert_equal %w[dos], hash[:two]
    assert_equal [], hash[:three]
  end
end
