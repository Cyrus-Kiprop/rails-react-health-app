class WelcomeController < ApplicationController
  skip_before_action :authorize_request
  skip_before_action :admin?
  def index
    json_response({message: 'Welcome to our Health App api'})
  end
end
