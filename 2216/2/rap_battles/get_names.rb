# script to get all names of participants of battles

# This method smells of :reek:UtilityFunction
def identify_removed_name(first_name, second_name)
  removed_name = nil
  if first_name.size != second_name.size && (first_name.include?(second_name) || second_name.include?(first_name))
    removed_name = first_name.size > second_name.size ? first_name : second_name
  end
  removed_name
end

# This method smells of :reek:NestedIterators
# This method smells of :reek:FeatureEnvy
def remove_repeated_names(array_of_names)
  array_of_names.each do |first_name|
    array_of_names.each do |second_name|
      removing_name = identify_removed_name(first_name, second_name)
      array_of_names.delete(removing_name) if removing_name
    end
  end
end

# This method smells of :reek:UtilityFunction
def get_participant(name)
  participant = ''
  if name.index('против')
    participant = name[0..name.index('против') - 1]
  elsif name.index('vs')
    participant = name[0..name.index('vs') - 1]
  elsif name.index('VS')
    participant = name[0..name.index('VS') - 1]
  end
  participant.strip!
end

array_with_names = []
file_with_participants = File.open('participants', 'w')
names_of_files = Dir['rap-battles/*']

names_of_files.each { |name| name.slice! 'rap-battles/' } # get rid of directory
names_of_files.each { |name| array_with_names << get_participant(name) } # get all names(repeated too)
array_with_names = array_with_names.uniq! # remove names that look identically
array_with_names = remove_repeated_names(array_with_names)

array_with_names.each { |name| file_with_participants.puts name }

file_with_participants.close
