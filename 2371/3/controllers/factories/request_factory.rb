require_relative '../request_handlers/onliner_request_handler'
require_relative '../request_handlers/azure_request_handler'
class RequestFactory
  def self.request_handler(type, **args)
    case type
    when 'onliner'
      OnlinerRequestHandler.new(args)
    when 'azure_api'
      AzureRequestHandler.new(args)
    else
      raise NotImplementedError
    end
  end
end
