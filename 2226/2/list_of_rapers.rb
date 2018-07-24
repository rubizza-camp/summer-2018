# This module storing rapers
module ListOfRapers
  def self.list_all_rapers
    @list_all_rapers ||= ListOfRapers.filter_rapers.flatten.uniq
  end

  def self.filter_rapers
    DataStorage.new.show_all_data.inject([]) do |array, (file_name, _file_content)|
      filtered_data = file_name.sub(/ротив_/, '').sub(/_\(.*/, '')
      array << filtered_data.sub(%r/^rap-battles\/_/, '').sub(/_$/, '').split('_п')
    end
  end
end
