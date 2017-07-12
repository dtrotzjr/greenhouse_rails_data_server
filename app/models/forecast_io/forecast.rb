module ForecastIo
  class Forecast < ActiveRecord::Base
    include WeatherHelper

    has_many :forecast_io_data, foreign_key: 'fio_forecast_id', class_name: 'ForecastIo::Datum'
    belongs_to :forecast_io_summary, :class_name => 'ForecastIo::Summary', foreign_key: 'summary_id'
    belongs_to :forecast_io_icon, :class_name => 'ForecastIo::Icon', foreign_key: 'icon_id'

    self.table_name = 'fio_forecast'

    def readable_time_stamp()
      return WeatherHelper.readable_time_date self.master_timestamp
    end
  end
end
