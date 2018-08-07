require_relative '../data_handlers/onliner_site_handler'
require_relative '../data_handlers/onliner_api_handler'
require_relative '../data_handlers/azure_api_handler'
# :nodoc:
class DataHandlerFactory
  def self.data_handler(type)
    case type
    when 'onliner_site'
      OnlinerSiteHandler.new
    when 'onliner_api'
      OnlinerApiHandler.new
    when 'azure_api'
      AzureApiHandler.new
    else
      raise NotImplementedError
    end
  end
end
