require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  # :reek:UncommunicativeMethodName
  # rubocop: disable Naming/MethodName
  def test_exceptions_inherit_from_Exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end
  # rubocop: enable Naming/MethodName

  # :reek:TooManyStatements
  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Layout/AlignParameters
  # rubocop: disable Style/StringLiterals
  # rubocop: disable Style/SignalException
  def test_rescue_clause
    result = nil
    begin
      fail "Oops"
    rescue StandardError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, ex.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, ex.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError), # __
      'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', ex.message
  end
  # rubocop: enable Layout/AlignParameters
  # rubocop: enable Style/SignalException
  # rubocop: enable Style/StringLiterals
  # rubocop: enable Metrics/MethodLength

  # :reek:TooManyStatements
  # rubocop: disable Style/StringLiterals
  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, "My Message"
    rescue MySpecialError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', ex.message
  end
  # rubocop: enable Style/StringLiterals

  # rubocop: disable Lint/HandleExceptions
  # rubocop: disable Style/SignalException
  # rubocop: disable Lint/UselessAssignment
  def test_ensure_clause
    result = nil
    begin
      fail 'Oops'
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end
  # rubocop: enable Lint/HandleExceptions
  # rubocop: enable Lint/UselessAssignment
  # rubocop: enable Style/SignalException

  # Sometimes, we must know about the unknown
  # rubocop: disable Style/RaiseArgs
  # rubocop: disable Layout/TrailingWhitespace
  def test_asserting_an_error_is_raised 
    # A do-end is a block, a topic to explore more later
    assert_raise(MySpecialError) do
      raise MySpecialError.new('New instances can be raised directly.')
    end
  end
  # rubocop: enable Style/RaiseArgs
  # rubocop: enable Layout/TrailingWhitespace
end
