require './battle'

# this module has only one method that simply returns info about battler, that you need
module ReturnInfo
  def return_info(rapper, elem)
    @info_about_battlers[rapper][elem]
  end
end

# this module provides methods for filling infos
module FillMethods
  def fill_counted_info_first(rapper)
    @info_about_battlers[rapper][2] = (return_info(rapper, 6).to_f / return_info(rapper, 1)).round(2)
  end

  def fill_counted_info_second(rapper)
    @info_about_battlers[rapper][4] = (return_info(rapper, 3).to_f / return_info(rapper, 0)).round(2)
  end

  def fill_counted_info(rapper, rapper_battles)
    fill_info_about_battlers(rapper, rapper_battles)
    fill_counted_info_first(rapper)
    fill_counted_info_second(rapper)
  end

  def fill_info_about_battlers(rapper, rapper_battles)
    info = @info_about_battlers
    rapper_battles.each do |battle_file_path|
      info[rapper] = Battle.new(battle_file_path).process_battle(info[rapper], rapper)
    end
    @info_about_battlers = info
  end

  # :reek:UtilityFunction
  def extract_battlers_names(battlers_names, battle)
    rapper = battle.partition(/( против | vs | VS )/).first + ' & '
    splitted_rapper = rapper.split(' & ')
    battlers_names << splitted_rapper.first.strip
    battlers_names << splitted_rapper[1].strip if Battle.new(battle).paired?
    battlers_names
  end

  def fill_battlers_names_array
    battlers_names = []
    @all_battles_paths.each do |battle|
      battlers_names = extract_battlers_names(battlers_names, battle)
    end
    battlers_names
  end
end
