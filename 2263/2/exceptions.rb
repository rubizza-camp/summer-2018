module VersusExceptions
  # Exception, that is raised when file given to some class is not a File object
  class VersusFileError < StandardError
    def initialize(obj, message = default_message)
      @obj = obj
      @message = message
    end

    private

    def default_message
      'Error. Given object is not a File'
    end
  end

  # Exception, that is raised when some class takes not a reqire object
  class VersusObjectError < StandardError
    def initialize(obj, message = default_message)
      @obj = obj
      @message = message
    end

    private

    def default_message
      'Error. Given object is not is not an object reqire class'
    end
  end

  # Exception, that is raised when name of file doesn't match pattern
  class ExplorerFileNameError < StandardError
    def initialize(path, message = default_message)
      @path = path
      @message = message
    end

    private

    def default_message
      'Error. File name does not match pattern'
    end
  end
end
