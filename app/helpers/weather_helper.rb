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
    # if bearing >=

  end
end