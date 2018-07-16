require 'optparse'

number_of_participants = 0
  OptionParser.new do |parser|
    parser.on("--top-bad-words=NAME") do |lib|
      number_of_participants = lib
    end
  end.parse!


def sum (total_words_array)
  arr_new = []
  number_of_rounds = 0
  count_word_all_round = 0
  count_bad_word_all_round = 0
  
  (0..total_words_array.length-1).step(2) do |i|
    count_word_all_round += total_words_array[i]
    number_of_rounds +=1
  end

  (1..total_words_array.length-1).step(2) do |i|
    count_bad_word_all_round += total_words_array[i]
  end

  # Number of words per battle
  num_words_per_battle = count_bad_word_all_round / number_of_rounds.to_f

  # Rounding up to two characters after the point
  num_words_per_battle = eval(sprintf('%8.3f', num_words_per_battle))

  # Average number of words in a round
  average_num_words = count_word_all_round / number_of_rounds

  arr_new.push(number_of_rounds, count_bad_word_all_round, num_words_per_battle, average_num_words) 
end


def processing_participant_file (file)
  participant_file = File.open(file)

  total_words_array = []
  bad_words = []
  total_words_count = 0
      # Total number of words in the battles and obscene words in the battles
      participant_file.each do |line|
      total_words_count += line.split(/[а-яА-Яa-zA-Z0-9_]{2,}/).length
      bad_words << line[/еб(а|[*])л(у|а|о)|бл(я|[*])| бл(я|[*])(д|т)ь|е(б|[*])л(а|о)(н|м)/]
      end

  participant_file.close

    # Number of words in a round and total obscene words in a battles
    total_words_array.push(total_words_count/3, bad_words.compact.length)
end  




st_men = []; r_f_men = []; oxxxy_men = []

# The path to the file "versus battle"
temp = Dir.glob("**versus/*") do |file|
  
  oxxxy_men += processing_participant_file(file) if file =~ /Oxxxymiron (против|VS)|Oxxxymirona (против|VS)|Oxxxymiron'a (против|VS)/
  r_f_men += processing_participant_file(file) if file =~ /Rickey F против/
  st_men += processing_participant_file(file) if file =~ /ST против/
end

  oxxxy_men = sum(oxxxy_men).unshift('Oxxxymiron')
  st_men = sum(st_men).unshift('ST')
  r_f_men = sum(r_f_men).unshift('Rickey')



  sort_arr = [oxxxy_men, st_men, r_f_men].sort! {|x, y| y[2] <=> x[2]}
  key_world = [ '','батлов','нецензурных слов', 'слова на баттл ', 'слова в раунде' ]
  spaces = "          "
  (0..number_of_participants.to_f-1).step(1) do |z|
  (0..sort_arr[z].length-1).step(1) { |i| print "#{sort_arr[z][i]}" +"  #{key_world[i]}" + "#{spaces[1..10 - sort_arr[z][i].to_s.length]}|      "}
  puts
  end
 



