require 'terminal-table'

# Comment gggggg
class AllRapers
  attr_reader :all_rapers

  def initilize
    @all_rapers = {}
  end

  def create_hash_rapers
    build_spis_names
  end

  private

  def list_all_battles
    @list_battles = Dir['*']
  end

  def read_variable_names
    @var_iskl_names = File.open('варианты_имен')
  end

  def variable_name(namee, battle)
    read_variable_names.each do |names|
      names = names.split(',')
      if names.include? namee
        add_name(names[0], battle)
      else
        add_name(namee, battle)
      end
    end
  end

  def add_name(namee, line)
    @all_rapers = @all_rapers.to_hash
    if @all_rapers.include?(namee)
      @all_rapers[namee] += [line]
    else
      @all_rapers[namee] = [line]
    end
  end

  def build_spis_names
    vs = 'против' || 'vs' || 'VS'
    list_all_battles.each do |battle|
      if battle.include? vs
        namee = battle[1...battle.index(vs) - 1]
        variable_name(namee, battle)
      end
    end
  end
end

a = AllRapers.new
a.create_hash_rapers
puts a.all_rapers.inspect
