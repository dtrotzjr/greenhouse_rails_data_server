module ForecastIo
  class Summary < ActiveRecord::Base
    has_one :forecast_io_datum, :class_name => 'ForecastIo::Datum'
    self.table_name = 'fio_summary'
  end
end