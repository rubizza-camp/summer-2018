# class ManipulationCommentScore
class ManipulationCommentScore
  attr_reader :score

  def initialize(score)
    @score = score
  end

  def run
    result = score * 100 / 0.5 - 100 if score <= 0.5
    result = (score - 0.5) * 100 / 0.5 if score >= 0.5
    result.round
  end
end
# class ManipulationArticleScore
class ManipulationArticleScore
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def run
    scores.sum / scores.size.to_i
  end
end
