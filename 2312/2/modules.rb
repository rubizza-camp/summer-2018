require './battle'

# this module has only one method that simply returns info about battler, that you need
module ReturnInfo
  def return_info(rapper, elem)
    @battlers_info[rapper][elem]
  end
end

# this module provides methods for filling infos
module FillMethods
  def fill_counted_info_first(rapper)
    @battlers_info[rapper][2] = (return_info(rapper, 6).to_f / return_info(rapper, 1)).round(2)
  end

  def fill_counted_info_second(rapper)
    @battlers_info[rapper][4] = (return_info(rapper, 3).to_f / return_info(rapper, 0)).round(2)
  end

  def fill_counted_info(rapper, rapper_battles)
    fill_info(rapper, rapper_battles)
    fill_counted_info_first(rapper)
    fill_counted_info_second(rapper)
  end

  def fill_info(rapper, rapper_battles)
    info = @battlers_info
    rapper_battles.each do |battle|
      info[rapper] = Battle.new(battle).fill_info(info[rapper], rapper)
    end
    @battlers_info = info
  end

  # :reek:UtilityFunction
  def extract_battlers_names(names_array, battle)
    rapper = battle.partition(/( против | vs | VS )/).first + ' & '
    splitted_rapper = rapper.split(' & ')
    names_array << splitted_rapper.first.strip
    names_array << splitted_rapper[1].strip if Battle.new(battle).double?
    names_array
  end

  def fill_names_array(all_battles)
    names_array = []
    all_battles.each do |battle|
      names_array = extract_battlers_names(names_array, battle)
    end
    names_array
  end
end
