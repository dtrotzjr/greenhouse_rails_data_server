module ForecastIo
  class Icon < ActiveRecord::Base
    has_one :forecast_io_datum, :class_name => 'ForecastIo::Datum'
    has_one :forecast_io_forecast, :class_name => 'ForecastIo::Forecast'
    self.table_name = 'fio_icon'
  end
end

