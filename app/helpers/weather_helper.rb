module WeatherHelper
  def convert_to_fahrenheit(celsius)
    return ((celsius * (9.0/5.0)) + 32.0).round(1).to_s
  end

  def readable_time_date(timestamp)
    dt = Time.at(timestamp).to_datetime
    Time::DATE_FORMATS[:gh_format] = '%a, %b %d, %Y - %I:%M:%S %p'
    return dt.to_formatted_s(:gh_format)
  end

  def bearing_to_icon_name(bearing)
    if bearing > 337.5 && bearing <= 22.5
      return 'wi-direction-up'
    elsif bearing > 22.5 && bearing <= 67.5
      return 'wi-direction-up-right'
    elsif bearing > 67.5 && bearing <= 112.5
      return 'wi-direction-right'
    elsif bearing > 112.5 && bearing <= 157.5
      return 'wi-direction-down-right'
    elsif bearing > 157.5 && bearing <= 202.5
      return 'wi-direction-down'
    elsif bearing > 202.5 && bearing <= 247.5
      return 'wi-direction-down-left'
    elsif bearing > 247.5 && bearing <= 292.5
      return 'wi-direction-left'
    else
      return 'wi-direction-up-left'
    end
  end
end