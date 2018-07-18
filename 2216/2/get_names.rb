# script to get all names of participants of battles

class ParticipantSelector
  def self.extract_name(name)
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

  def remove_repeated_names(array_of_names, pairs)
    pairs.each { |names| array_of_names.delete(find_deleted_name(names)) }
  end

  private

  def find_deleted_name(names)
    first_name = names[0]
    second_name = names[1]
    if first_name.size != second_name.size && (first_name.include?(second_name) || second_name.include?(first_name))
      removing_name = first_name.size > second_name.size ? first_name : second_name
    else
      removing_name = ''
    end
  end
end

# ------------------------------------------------------------------------------
array_with_names = []
file_with_participants = File.open('participants', 'w')
file_names = Dir['rap-battles/*']

selector = ParticipantSelector.new
file_names.each { |name| name.slice! 'rap-battles/' } # get rid of directory
file_names.each { |name| array_with_names << ParticipantSelector.extract_name(name) } # get all names(repeated too)

array_with_names = array_with_names.uniq! # remove names that look identically
pairs = array_with_names.combination(2).to_a
selector.remove_repeated_names(array_with_names, pairs)
array_with_names.each { |name| file_with_participants.puts name }

file_with_participants.close
