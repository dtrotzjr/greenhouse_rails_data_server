module Greenhouse
  class SystemDatum < ActiveRecord::Base
    include WeatherHelper

    belongs_to :greenhouse_data_point, class_name: 'Greenhouse::DataPoint'

    self.table_name = 'gh_system_data'

    def temperature_as_fahrenheit_string
      return self.convert_to_fahrenheit self.temperature
    end
  end
end

