module ForecastIo
  class Forecast < ActiveRecord::Base
    include WeatherHelper

    has_many :forecast_io_data, foreign_key: 'fio_forecast_id', class_name: 'ForecastIo::Datum'
    self.table_name = 'fio_forecast'

    def readable_time_stamp()
      return self.readable_time_date self.master_timestamp
    end
  end
end
