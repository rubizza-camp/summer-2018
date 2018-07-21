require_relative 'RapersArray'
# This class formats the data
class TopBadWords
  def self.sort_fodrs
    @array_after_sort = RapersArray.battle_men_array.sort! do |x_col, y_col|
      y_col[2] <=> x_col[2]
    end
    @key_world = ['', 'батлов', 'нецензурных слов',
                  'слова на батл', 'слова в раунде']
  end

  def self.print_bad(num_of_part)
    sort_fodrs
    (0...num_of_part).step(1) do |z_ar|
      (0...@array_after_sort[z_ar].length - 1).step(1) do |col|
        print "#{@array_after_sort[z_ar][col]} #{@key_world[col]}"\
        "#{'          '[1..10 - @array_after_sort[z_ar][col].to_s.length]}|   "
      end
      puts
    end
  end
end
