class MemberControl
  def find_members_name
    @members = []
    Dir.foreach('versus-battle') do |file|
      for_delete = file[/\s{1}(против|vs|VS){1}\s{1}.+\z/]
      verification_of_existence(file.chomp(for_delete), file)
    end
    @members
  end

  def verification_of_existence(member_name, file)
    return member_name if member_name.include?('.') || member_name.include?('..')
    new_member(member_name) unless search_in_array(member_name, @members, :name)
    temp = @members.index(search_in_array(member_name, @members, :name))
    fill = FillMembersInfo.new
    fill.add_info(@members[temp], file)
  end

  def new_member(member_name)
    member = {}
    member[:name] = member_name
    create_cases(member)
    @members << member
  end

  def create_cases(member)
    member[:battles] = 0
    member[:bad_words] = 0
    member[:avr_words] = 0
    member[:words_per_round] = 0
    member[:rounds] = 0
  end
end
