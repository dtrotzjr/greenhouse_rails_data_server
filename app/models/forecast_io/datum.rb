module ForecastIo
  class Datum < ActiveRecord::Base
    include WeatherHelper
    belongs_to :forecast_io_forecast, :class_name => 'ForecastIo::Forecast'
    belongs_to :forecast_io_summary, :class_name => 'ForecastIo::Summary', foreign_key: 'summary_id'
    belongs_to :forecast_io_icon, :class_name => 'ForecastIo::Icon', foreign_key: 'icon_id'

    self.table_name = 'fio_data'

    def self.currentForecast()
      max_fio_timestamp = ForecastIo::Forecast.where(type_id: 1).maximum('master_timestamp')
      current_fio_data = ForecastIo::Forecast.where(master_timestamp: max_fio_timestamp).first
      return current_fio_data.forecast_io_data.first
    end

    def readable_time_stamp()
      return WeatherHelper.readable_time_date self.time
    end

    def bearing_icon
      return bearing_to_icon_name(self.wind_bearing)
    end

  end
end