class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user, :admin
  before_action :admin?

  def admin?
    @admin = authorize_request[:admin]
    raise(ExceptionHandler::MissingToken, Message.unauthorized) unless @admin
  end

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
