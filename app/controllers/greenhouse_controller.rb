require 'date'

class GreenhouseController < ApplicationController
  include WeatherHelper
  # GET /greenhouse
  # GET /greenhouse.json
  def index
    max_gh_timestamp = Greenhouse::DataPoint.maximum('timestamp');
    @current_gh_data = Greenhouse::DataPoint.where(timestamp: max_gh_timestamp).first
  end

  def hourly_average_temp_last_24_hours
    last_24_hours_timestamp = (Time.now - 86400).to_i
    items = ForecastIo::Forecast.joins(:forecast_io_data).where(" master_timestamp >= ? AND type_id = ?", last_24_hours_timestamp, 1).pluck(:time, :temperature)
    if !items.nil? && items.count > 0
      current_hour_timestamp = items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      retval = Array.new
      items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_f = current_hour_total_temps.to_f/current_hour_temp_count.to_f
            avg = [hour, avg_f]
            retval.push(avg)
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      return retval
    end
    return nil
  end

  def stacked_hourly_average_temps_last_24_hours
    retval = Array.new
    last_24_hours_timestamp = (Time.now - 86400).to_i

    # Forecast.io
    fio_items = ForecastIo::Forecast.joins(:forecast_io_data).where(" master_timestamp >= ? AND type_id = ?", last_24_hours_timestamp, 1).pluck(:time, :temperature)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_f = current_hour_total_temps.to_f/current_hour_temp_count.to_f
            avg = [hour, avg_f]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      retval.push({name: 'Forecast.io', data: fio_avg_items})
    end

    # Greenhouse internal sensor
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_sensor_data).where(" timestamp >= ? AND gh_sensor_data.sensor_id = ?", last_24_hours_timestamp, 1).pluck(:timestamp, :temperature)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_c = current_hour_total_temps.to_f/current_hour_temp_count.to_f
            avg_f = convert_to_fahrenheit(avg_c)
            avg = [hour, avg_f]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      retval.push({name: 'Internal', data: fio_avg_items})
    end

    # Greenhouse external sensor
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_sensor_data).where(" timestamp >= ? AND gh_sensor_data.sensor_id = ?", last_24_hours_timestamp, 2).pluck(:timestamp, :temperature)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_c = current_hour_total_temps.to_f/current_hour_temp_count.to_f
            avg_f = convert_to_fahrenheit(avg_c)
            avg = [hour, avg_f]
            fio_avg_items.push(avg)
            logger.info("Pushing: #{hour} - #{avg_f}")
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      retval.push({name: 'External', data: fio_avg_items})
    end
  end

  def stacked_hourly_soc_temp_last_24_hours
    retval = Array.new
    last_24_hours_timestamp = (Time.now - 86400).to_i

    # Greenhouse internal sensor
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_sensor_data).where(" timestamp >= ? AND gh_sensor_data.sensor_id = ?", last_24_hours_timestamp, 1).pluck(:timestamp, :temperature)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_temps = 0
      current_hour_temp_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_temp_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_c = current_hour_total_temps.to_f/current_hour_temp_count.to_f
            avg_f = convert_to_fahrenheit(avg_c)
            avg = [hour, avg_f]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_total_temps = 0
            current_hour_temp_count = 0
          end
        else
          current_hour_total_temps += temp
          current_hour_temp_count += 1
        end

      end
      retval.push({name: 'Internal', data: fio_avg_items})
    end

    # Greenhouse soc temp
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_system_data).where(" timestamp >= ?", last_24_hours_timestamp).pluck(:timestamp, :soc_temperature)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_cumulative_soc_temps = 0
      current_hour_soc_temps_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_soc_temps_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_c = current_hour_cumulative_soc_temps.to_f/current_hour_soc_temps_count.to_f
            avg_f = convert_to_fahrenheit(avg_c)
            avg = [hour, avg_f]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_cumulative_soc_temps = 0
            current_hour_soc_temps_count = 0
          end
        else
          current_hour_cumulative_soc_temps += temp
          current_hour_soc_temps_count += 1
        end

      end
      retval.push({name: 'CPU Temp', data: fio_avg_items})
    end

  end

  def stacked_hourly_average_humids_last_24_hours
    retval = Array.new
    last_24_hours_timestamp = (Time.now - 86400).to_i

    # Forecast.io
    fio_items = ForecastIo::Forecast.joins(:forecast_io_data).where(" master_timestamp >= ? AND type_id = ?", last_24_hours_timestamp, 1).pluck(:time, :humidity)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_humids = 0
      current_hour_humid_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_humid_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_humid = current_hour_total_humids.to_f/current_hour_humid_count.to_f * 100.0
            avg = [hour, avg_humid]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_total_humids = 0
            current_hour_humid_count = 0
          end
        else
          current_hour_total_humids += temp
          current_hour_humid_count += 1
        end

      end
      retval.push({name: 'Forecast.io', data: fio_avg_items})
    end

    # Greenhouse internal sensor
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_sensor_data).where(" timestamp >= ? AND gh_sensor_data.sensor_id = ?", last_24_hours_timestamp, 1).pluck(:timestamp, :humidity)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_humids = 0
      current_hour_humid_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_humid_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_humidity = current_hour_total_humids.to_f/current_hour_humid_count.to_f
            avg = [hour, avg_humidity]
            fio_avg_items.push(avg)
            current_hour_timestamp = time
            current_hour_total_humids = 0
            current_hour_humid_count = 0
          end
        else
          current_hour_total_humids += temp
          current_hour_humid_count += 1
        end

      end
      retval.push({name: 'Internal', data: fio_avg_items})
    end

    # Greenhouse external sensor
    fio_items = Greenhouse::DataPoint.joins(:greenhouse_sensor_data).where(" timestamp >= ? AND gh_sensor_data.sensor_id = ?", last_24_hours_timestamp, 2).pluck(:timestamp, :humidity)
    if !fio_items.nil? && fio_items.count > 0
      current_hour_timestamp = fio_items.first[0]
      current_hour_total_humids = 0
      current_hour_humid_count = 0
      fio_avg_items = Array.new
      fio_items.each do |item|
        time = item[0]
        temp = item[1]
        if time > (current_hour_timestamp + 60*60)
          if current_hour_humid_count > 0
            ts = (current_hour_timestamp + time)/2
            dt = DateTime.strptime(String(ts),'%s')
            to = dt.to_time
            hour = '%02d' % to.hour
            avg_humidity = current_hour_total_humids.to_f/current_hour_humid_count.to_f
            avg = [hour, avg_humidity]
            fio_avg_items.push(avg)
            logger.info("Pushing: #{hour} - #{avg_humidity}")
            current_hour_timestamp = time
            current_hour_total_humids = 0
            current_hour_humid_count = 0
          end
        else
          current_hour_total_humids += temp
          current_hour_humid_count += 1
        end

      end
      retval.push({name: 'External', data: fio_avg_items})
    end
  end

  private

end
