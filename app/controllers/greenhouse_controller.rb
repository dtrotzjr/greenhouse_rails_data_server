require 'date'

class GreenhouseController < ApplicationController

  # GET /greenhouse
  # GET /greenhouse.json
  def index
    max_gh_timestamp = Greenhouse::DataPoint.maximum('timestamp');
    @current_gh_data = Greenhouse::DataPoint.where(timestamp: max_gh_timestamp).first

    # max_fio_timestamp = ForecastIO::Forecast.where(type_id: 1).maximum('master_timestamp')
    # @current_fio_data = ForecastIO::Forecast.where(master_timestamp: max_fio_timestamp)

  end

  private

end
