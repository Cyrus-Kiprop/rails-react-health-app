class WelcomeController < ApplicationController
  def index
    json_response({message: 'Welcome to our Health App api'})
  end
end
