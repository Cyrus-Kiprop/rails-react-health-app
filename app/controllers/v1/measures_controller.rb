module V1
  class MeasuresController < ApplicationController
    before_action :set_measure, only: %i[show update destroy]
    before_action :admin?, only: %i[create update destroy]

    def index
      @measure = Measure.all
      json_response(@measure)
    end

    def create
      @measure = current_user.measures.create!(measure_params)
      json_response(@measure, :created)
    end

    def show
      json_response(@measure)
    end

    def update
      @measure.update(measure_params)
      head :no_content
    end

    def destroy
      @measure.destroy
      head :no_content
    end

    private

    def measure_params
      # whitelist params
      params.permit(:body_part_name)
    end

    def set_measure
      @measure = Measure.find(params[:id])
    end
  end
end
