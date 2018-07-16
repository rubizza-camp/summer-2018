class HelperDAO
  def read_from_file(path)
    file = File.new(path, 'r')
    buffer = []
    counter = 0
    while (line = file.gets)
      buffer << '           ' + line
      counter += 1
    end
    file.close
    buffer
  end
end
