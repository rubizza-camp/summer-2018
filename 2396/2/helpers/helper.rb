require './helpers/raper_helper'
require './helpers/raper_list_helper'
require './helpers/raper_list_objects_helper'
# This is module Helper
module Helper
  def self.clearing_text_from_garbage(text)
    arr_words = text.delete(",.!?\"\':;«»\n").downcase.split(' ')
    arr_words.select! { |word| word.size > 3 }
  end
end
