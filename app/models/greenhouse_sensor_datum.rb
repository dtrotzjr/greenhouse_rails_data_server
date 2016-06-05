class GreenhouseSensorDatum < ActiveRecord::Base
  belongs_to :greenhouse_data_point

  self.table_name = "gh_sensor_data"

  def temperature_as_fahrenheit_string
    tf = ((self.temperature * (9.0/5.0)) + 32.0).round(1).to_s
    return tf
  end

  def which_sensor_as_string
    if self.sensor_id == 1
      return "Greenhouse"
    else
      return "Outside"
    end
  end
end
