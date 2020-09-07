class V1::AdminController < ApplicationController
  before_action :admin?

  def index
    @measure = current_user.measures
    json_response(@measure)
  end
end
