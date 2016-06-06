module ForecastIo
  class ForecastType < ActiveRecord::Base
    has_many :forecast_io_forecasts, foreign_key: 'type_id', class_name: 'ForecastIo::Forecast'
    self.table_name = 'fio_forecast_type'
  end
end
