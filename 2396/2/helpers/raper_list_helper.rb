# This is module RaperListHelper
module RaperListHelper
  def self.find_names(titles)
    titles.split(/против|vs/i, 2).map do |title|
      title.strip.gsub(/\(.*\)/, '').strip.delete('')
    end
  end

  def self.merge_similar_names(names)
    names.select! do |name|
      name unless names.include?(name[0..(name.size / 2)]) && name.size < 3
    end
  end
end
