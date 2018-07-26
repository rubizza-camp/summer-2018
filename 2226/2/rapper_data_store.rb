# Class with data for 1 rapper
class RapperDataStore
  def initialize(rapper_name)
    @rapper_name = rapper_name
    @all_data_hash = DataStorage.new('rap-battles/*').show_all_data
  end

  def data_for_one_rapper
    @data_for_one_rapper ||= filter_one_rapper_data
  end

  def filter_one_rapper_data
    @all_data_hash.each_with_object({}) do |(file_name, file_content), hash|
      hash[file_name.to_s] = file_content.to_s if file_name =~ /#{@rapper_name}_против/
    end
  end
end
