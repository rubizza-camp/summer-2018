# The SimilarItemsSearcher responsible for search similar items
class SimilarItemsSearcher
  def self.compare_items(first_elem, second_elem)
    first_elem.include?(second_elem) || second_elem.include?(first_elem)
  end
end
