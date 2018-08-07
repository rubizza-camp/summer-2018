# -Open the catalog
# - Look for a file name with a regular expression
# - if appropriate, we accumulate information
class FormationParticipants
  include ProcessingParticipant

  attr_reader :choice_batlers, :mens

  def initialize(choice_batlers)
    @choice_batlers = choice_batlers
    @mens = Array.new(choice_batlers.length, [])
  end

  def name_comparison
    Dir.glob('**versus/*') do |fl|
      name_comparison_in(fl)
    end
    mens
  end

  private

  def name_comparison_in(file)
    (0...choice_batlers.length).step(1) do |count|
      mens[count] += processing_participant_file(file) if
      file =~ /#{choice_batlers[count].chomp.to_s}/
    end
  end
end
