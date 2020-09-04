module V1
  class MeasurementsController < ApplicationController
    before_action :set_measure
    before_action :set_measure_item, only: %i[show update destroy]

    # GET /measures/:measure_id/measurements
    def index
      json_response(@measure.measurements.paginate(page: params[:page], per_page: 20))
    end

    # GET /measures/:measure_id/measurements/:id
    def show
      json_response(@measurement)
    end

    # POST /measures/:measure_id/measurements
    def create
      @measure.measurements.create!(item_params)
      json_response(@measure, :created)
    end

    # PUT /measures/:measure_id/measurements/:id
    def update
      @measurement.update(item_params)
      head :no_content
    end

    # DELETE /measures/:measure_id/measurements/:id
    def destroy
      @measurement.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:size)
    end

    def set_measure
      @measure = Measure.find(params[:measure_id])
    end

    def set_measure_item
      @measurement = @measure.measurements.find_by!(id: params[:id]) if @measure
    end
  end
end
