module Rap
  class FirstLevelPrinter
    def self.print(rappers_array, lim)
      if lim <= rappers_array.size
        lim.times { |ind| puts rappers_array[ind].to_s }
      else
        puts rappers_array.each(&:to_s)
      end
    end
  end

  class SecondLevelPrinter
    def self.print(result)
      case result
      when String
        puts result
      when Array
        result.each { |elem| puts "\"#{elem[0]}\" - #{elem[1]} раз" }
      end
    end
  end

  class ThirdLevelPrinter
    def self.print(res)
      res.each do |battle, plagiat|
        puts battle
        puts !plagiat.empty? ? plagiat : 'НЕТ ПЛАГИАТА'
        puts
      end
    end
  end
end
