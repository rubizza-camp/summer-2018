class FileReader
  def read(files)
    get_all_text(files)
  end

  private

  # :reek:FeatureEnvy
  # :reek:NestedIterators
  # :reek:TooManyStatements
  def get_all_text(files)
    files.inject('') do |text, file_name|
      fh = open("data/#{file_name.gsub(/:[()"'*.-]/) { |sym| '\\' + sym }.chomp}")
      text + fh.read
    end
  end
end
