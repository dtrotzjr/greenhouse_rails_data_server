module Greenhouse
  class DataPoint < ActiveRecord::Base
    include WeatherHelper
    has_many :greenhouse_sensor_data, foreign_key: 'gh_data_point_id', class_name: 'Greenhouse::SensorDatum'
    self.table_name = 'gh_data_points'

    def readable_time_stamp()
      return self.readable_time_date self.timestamp
    end
  end
end

