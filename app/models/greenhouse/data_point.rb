module Greenhouse
  class DataPoint < ActiveRecord::Base
    include WeatherHelper
    has_many :greenhouse_sensor_data, foreign_key: 'gh_data_point_id', class_name: 'Greenhouse::SensorDatum'
    has_many :greenhouse_system_data, foreign_key: 'gh_data_point_id', class_name: 'Greenhouse::SystemDatum'
    has_many :greenhouse_image_data, foreign_key: 'gh_data_point_id', class_name: 'Greenhouse::ImageDatum'

    self.table_name = 'gh_data_points'

    def readable_time_stamp()
      return WeatherHelper.readable_time_date self.timestamp
    end
  end
end

