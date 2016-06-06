module Greenhouse
  class SensorDatum < ActiveRecord::Base
    include WeatherHelper

    belongs_to :greenhouse_data_point, class_name: 'Greenhouse::DataPoint'

    self.table_name = 'gh_sensor_data'

    def temperature_as_fahrenheit_string
      return self.convert_to_fahrenheit self.temperature
    end

    def which_sensor_as_string
      if self.sensor_id == 1
        return 'Greenhouse'
      else
        return 'Outside'
      end
    end
  end
end

