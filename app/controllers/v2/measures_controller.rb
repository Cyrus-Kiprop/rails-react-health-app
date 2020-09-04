class V2::MeasuresController < ApplicationController
  def index
    json_response({message: 'hello there'}.to_json)
  end
end
