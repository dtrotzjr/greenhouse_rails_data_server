module ForecastIo
  class DayInfo < ActiveRecord::Base
    has_many :forecast_io_data, foreign_key: 'fio_day_info_id', class_name: 'ForecastIo::Datum'
    self.table_name = 'fio_day_info'
  end
end

