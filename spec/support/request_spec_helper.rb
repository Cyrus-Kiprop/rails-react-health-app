module RequestSpecHelper
  # Parse all the json files coming from ActiveRecord
  #
  def json
    JSON.parse(response.body)
  end
end
