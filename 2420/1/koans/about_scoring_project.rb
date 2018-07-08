require File.expand_path(File.dirname(__FILE__) + '/neo')


# A greed roll is scored as follows:
#
# * s 1-1000
#
# * 555- 500, 111 - 100. 
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points

def score(dice)
 
  total = 0
  count = [0, 0, 0, 0, 0, 0]

  dice.each do |die|
    count[ die - 1 ] += 1
  end

  # iterate over each, and handle points for singles and triples
  count.each_with_index do |count, index|
    if count == 3
      total = doTriples(index + 1, total )
    elsif count < 3
      total = doSingles(index + 1, count, total )
    elsif count > 3
      total = doTriples(index + 1, total )
      total = doSingles(index + 1, count % 3, total )
    end
  end

  total
end

def doTriples(number, total )
  if number == 1
    total += 1000
  else
    total += (number ) * 100
  end
  total
end

def doSingles(number, count, total )
  if number == 1
    total += (100 * count )
  elsif number == 5
    total += (50 * count )
  end
  total
end

class AboutScoringProject < Neo::Koan #class AboutScoringProject
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1, 5, 5, 1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2, 3, 4, 6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1, 1, 1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2, 2, 2])
    assert_equal 300, score([3, 3, 3])
    assert_equal 400, score([4, 4, 4])
    assert_equal 500, score([5, 5, 5])
    assert_equal 600, score([6, 6, 6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2, 5, 2, 2, 3])
    assert_equal 550, score([5, 5, 5, 5])
    assert_equal 1100, score([1, 1, 1, 1])
    assert_equal 1200, score([1, 1, 1, 1, 1])
    assert_equal 1150, score([1, 1, 1, 5, 1])
  end
end
