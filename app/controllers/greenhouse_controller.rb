require 'date'

class GreenhouseController < ApplicationController

  # GET /greenhouse
  # GET /greenhouse.json
  def index
    max_gh_timestamp = Greenhouse::DataPoint.maximum('timestamp');
    @current_gh_data = Greenhouse::DataPoint.where(timestamp: max_gh_timestamp).first
  end

  def hourly_average_temp_last_24_hours
    last_24_hours_timestamp = (Time.now - 86400).to_i
    items = ForecastIo::Forecast.joins(:forecast_io_data).where(" master_timestamp >= ? AND type_id = ?", last_24_hours_timestamp, 1).pluck(:time, :temperature)
    if !items.nil? && items.count > 0
      current_hour_timestamp = items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      retval = Array.new
      items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg = [hour, (current_hour_total_temps/current_hour_temp_count)]
            retval.push(avg)
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      return retval
    end
    return nil
  end

  private

end
