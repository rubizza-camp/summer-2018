def pluralize(count, words)
  return words.last if (10..20).cover? count
  type = count % 10
  return words.first if type == 1
  return words[1] if (2..4).cover? type
  words.last
end
