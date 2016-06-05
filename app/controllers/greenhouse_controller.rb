require 'date'

class GreenhouseController < ApplicationController

  # GET /greenhouse
  # GET /greenhouse.json
  def index
    max_timestamp = GreenhouseDataPoint.maximum("timestamp");
    @current_data = GreenhouseDataPoint.where(timestamp: max_timestamp).first


  end

  def readable_time
    dt = Time.at(@current_data.timestamp).to_datetime
    Time::DATE_FORMATS[:gh_format] = '%a, %b %d, %Y - %I:%M:%S %p'
    return dt.to_formatted_s(:gh_format)
  end




  private

end
