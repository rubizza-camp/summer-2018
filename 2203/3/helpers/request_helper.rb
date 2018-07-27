# Class generate request to Azure API
class RequestMaker
  def self.make_request(uri, id, comment)
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = YAML.load_file(File.join(Dir.pwd, 'config/secrets.yml'))['azure']['AZURE_KEY']
    request.body = { 'documents': [
      { 'id' => id, 'language' => 'ru', 'text' => comment }
    ] }.to_json
    request
  end
end
