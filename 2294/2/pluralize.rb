# Pure pluralize
class Pluralize
  def self.change(count, words)
    return words[-1] if (10..20).cover? count
    type = count % 10
    return words[0] if type == 1
    return words[1] if (2..4).cover? type
    words.last
  end
end
