class OnlinerSiteHandler
  def handle_data(data)
    Hash[*data.scan(/entity-id|entity-type|(?<=entity-id=")\d+|(?<=entity-type=")[\w.]+/i)]
  end
end