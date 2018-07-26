# This class sis used for storing data
class DataStorage
  def initialize(folder_name)
    @folder_name = folder_name
  end

  def show_all_data
    Dir.glob(@folder_name).each_with_object({}) do |file_name, hash|
      hash[file_name] = File.read(file_name)
    end
  end

  def self.list_all_rappers
    @list_all_rappers ||= DataStorage.filter_rappers.flatten.uniq
  end

  def self.filter_rappers
    DataStorage.new('rap-battles/*').show_all_data.inject([]) do |array, (file_name, _file_content)|
      filtered_data = file_name.sub(/ротив_/, '').sub(/_\(.*/, '')
      array << filtered_data.sub(%r/^rap-battles\/_/, '').sub(/_$/, '').split('_п')
    end
  end
end
