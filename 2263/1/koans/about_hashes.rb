require File.expand_path(File.dirname(__FILE__) + '/neo')
# rubocop:disable Style/WordArray, Lint/ShadowingOuterLocalVariable, Metrics/AbcSize, Style/EmptyLiteral
# rubocop:disable Style/HashSyntax
# :reek:UncommunicativeModuleName
# :reek:IrresponsibleModule
class AboutHashes < Neo::Koan
  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_hash_literals
    hash = { :one => 'uno', :two => 'dos' }
    assert_equal 2, hash.size
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_accessing_hashes
    hash = { :one => 'uno', :two => 'dos' }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_accessing_hashes_with_fetch
    hash = { :one => 'uno' }
    assert_equal 'uno', hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_changing_hashes
    hash = { :one => 'uno', :two => 'dos' }
    hash[:one] = 'eins'

    expected = { :one => 'eins', :two => 'dos' }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_hash_is_unordered
    hash1 = { :one => 'uno', :two => 'dos' }
    hash2 = { :two => 'dos', :one => 'uno' }

    assert_equal true, hash1 == hash2
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  def test_hash_keys
    hash = { :one => 'uno', :two => 'dos' }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  def test_hash_values
    hash = { :one => 'uno', :two => 'dos' }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?('uno')
    assert_equal true, hash.values.include?('dos')
    assert_equal Array, hash.values.class
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_combining_hashes
    hash = { 'jim' => 53, 'amy' => 20, 'dan' => 23 }
    new_hash = hash.merge('jim' => 54, 'jenny' => 26)

    assert_equal true, hash != new_hash

    expected = { 'jim' => 54, 'amy' => 20, 'dan' => 23, 'jenny' => 26 }
    assert_equal true, expected == new_hash
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new('dos')
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal 'dos', hash2[:two]
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  def test_default_value_is_the_same_object
    hash = Hash.new([])

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal ['uno', 'dos'], hash[:one]
    assert_equal ['uno', 'dos'], hash[:two]
    assert_equal ['uno', 'dos'], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end

  # :reek:UncommunicativeMethodName
  # :reek:UncommunicativeVariableName
  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  def test_default_value_with_block
    hash = Hash.new { |hash, key| hash[key] = [] }

    hash[:one] << 'uno'
    hash[:two] << 'dos'

    assert_equal ['uno'], hash[:one]
    assert_equal ['dos'], hash[:two]
    assert_equal [], hash[:three]
  end
end
# rubocop:enable Style/WordArray, Lint/ShadowingOuterLocalVariable, Metrics/AbcSize, Style/EmptyLiteral
# rubocop:enable Style/HashSyntax
