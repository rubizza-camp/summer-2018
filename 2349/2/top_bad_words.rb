# This class formats the data
class TopBadWords
  attr_reader :number_peaple, :array

  def initialize(number_peaple, array)
    @number_peaple = number_peaple
    @array = array
  end

  def print_bad
    sort_wodrs
    (0...number_peaple).step(1) do |z_ar|
      print_print_bad_in(z_ar)
      puts
    end
  end

  private

  def sort_wodrs
    @array = array.sort! do |x_col, y_col|
      y_col[2] <=> x_col[2]
    end
  end

  def print_print_bad_in(z_ar)
    key_world = ['', 'батлов', 'нецензурных слов',
                 'слова на батл', 'слова в раунде']
    (0...@array[z_ar].length - 1).step(1) do |col|
      print "#{@array[z_ar][col]} #{key_world[col]}"\
      "#{'          '[1..10 - @array[z_ar][col].to_s.length]}|   "
    end
  end
end
