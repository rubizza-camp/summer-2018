require 'yaml'

class Setting
  CONFIG_FILE = 'secrets.yml'.freeze

  class << self
    def get(key)
      load_settings[key.to_s]
    end

    def load_settings
      YAML.safe_load(File.read(file_path))
    end

    private

    def file_path
      "./config/#{CONFIG_FILE}"
    end
  end
end
