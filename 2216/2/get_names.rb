# script to get all names of participants of battles

array_with_names = []
file_with_participants = File.open('participants', 'w')
file_names = Dir['rap-battles/*']

file_names.each { |name| name.slice! 'rap-battles/' } # get rid of directory
file_names.each do |name|
  array_with_names << name[0..name.index(name.match(/( против | vs )/i).to_s) - 1].strip! # get all names(repeated too)
end

array_with_names = array_with_names.uniq! # remove names that look identically
array_with_names.each { |name| file_with_participants.puts name }

file_with_participants.close
