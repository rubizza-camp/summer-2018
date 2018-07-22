require_relative 'RapersArray'
# This class formats the data
class TopBadWords
  def self.sort_fodrs
    @array = RapersArray.battle_men_array.sort! do |x_col, y_col|
      y_col[2] <=> x_col[2]
    end
    @key_world = ['', 'батлов', 'нецензурных слов',
                  'слова на батл', 'слова в раунде']
  end

  def self.print_print_bad_in(z_ar)
    (0...@array[z_ar].length - 1).step(1) do |col|
      print "#{@array[z_ar][col]} #{@key_world[col]}"\
      "#{'          '[1..10 - @array[z_ar][col].to_s.length]}|   "
    end
  end

  def self.print_bad(num_of_part)
    sort_fodrs
    (0...num_of_part).step(1) do |z_ar|
      print_print_bad_in(z_ar)
      puts
    end
  end
end
