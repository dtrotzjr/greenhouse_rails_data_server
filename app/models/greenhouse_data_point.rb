class GreenhouseDataPoint < ActiveRecord::Base
  has_many :greenhouse_sensor_data, foreign_key: "gh_data_point_id", class_name: "GreenhouseSensorDatum"
  self.table_name = "gh_data_points"

end
