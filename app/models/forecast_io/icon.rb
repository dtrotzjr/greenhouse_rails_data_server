module ForecastIo
  class Icon < ActiveRecord::Base
    has_many :forecast_io_data, foreign_key: 'icon_id', class_name: 'ForecastIo::Datum'
    has_many :forecast_io_forecasts, foreign_key: 'icon_id', class_name: 'ForecastIo::Forecast'
    self.table_name = 'fio_icon'
  end
end

