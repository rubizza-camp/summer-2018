require File.expand_path(File.dirname(__FILE__) + '/neo')
# This class smells of :reek:RepeatedConditional
# About sandwich code
# This class smells of :reek:RepeatedConditional
class AboutSandwichCode < Neo::Koan
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  # :reek:RepeatedConditional
  def count_lines(file_name)
    file = open(file_name) # rubocop:disable Security/Open
    count = 0
    count += 1 while file.gets
    count 
  ensure
    file.close if file
  end

  def test_counting_lines
    assert_equal 4, count_lines('example_file.txt')
  end

  # ------------------------------------------------------------------
  # :reek:FeatureEnvy
  # :reek:DuplicateMethodCall
  def find_line(file_name)
    file = open(file_name) # rubocop:disable Security/Open
    line = file.gets
    while line
      return line if line =~ /e/
      line = file.gets
    end
  ensure
    file.close if file
  end

  def test_finding_lines
    assert_equal "test\n", find_line('example_file.txt')
  end

  # ------------------------------------------------------------------
  # THINK ABOUT IT:
  #
  # The count_lines and find_line are similar, and yet different.
  # They both follow the pattern of "sandwich code".
  #
  # Sandwich code is code that comes in three parts: (1) the top slice
  # of bread, (2) the meat, and (3) the bottom slice of bread.  The
  # bread part of the sandwich almost always goes together, but
  # the meat part changes all the time.
  #
  # Because the changing part of the sandwich code is in the middle,
  # abstracting the top and bottom bread slices to a library can be
  # difficult in many languages.
  #
  # (Aside for C++ programmers: The idiom of capturing allocated
  # pointers in a smart pointer constructor is an attempt to deal with
  # the problem of sandwich code for resource allocation.)
  #
  # Consider the following code:
  #

  def file_sandwich(file_name)
    file = open(file_name) # rubocop:disable Security/Open
    yield(file)
  ensure
    file.close if file
  end

  # Now we write:

  def count_lines_two(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      count += 1 while file.gets
      count
    end
  end

  def test_counting_lines_two
    assert_equal 4, count_lines_two('example_file.txt')
  end

  # ------------------------------------------------------------------

  def find_line_two(file_name)
    file_sandwich(file_name) do |file|
      while (line = file.gets)
        return line if line =~ /e/
      end
    end
  end

  def test_finding_lines_two
    assert_equal "test\n", find_line_two('example_file.txt')
  end

  # ------------------------------------------------------------------

  def count_lines_three(file_name)
    open(file_name) do |file| # rubocop:disable Security/Open
      count = 0
      count += 1 while file.gets
      count
    end
  end

  def test_open_handles_the_file_sandwich_when_given_a_block
    assert_equal 4, count_lines_three('example_file.txt')
  end
end
