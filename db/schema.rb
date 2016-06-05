# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "fio_data", force: :cascade do |t|
    t.integer "time"
    t.float   "nearest_storm_distance"
    t.float   "nearest_storm_bearing"
    t.float   "precip_intensity"
    t.float   "precip_intensity_max"
    t.integer "precip_intensity_max_time"
    t.float   "precip_intensity_error"
    t.float   "precip_accumulation"
    t.float   "precip_probability"
    t.text    "precip_type"
    t.float   "temperature"
    t.float   "temperature_min"
    t.integer "temperature_min_time"
    t.float   "temperature_max"
    t.integer "temperature_max_time"
    t.float   "apparent_temperature"
    t.float   "apparent_temperature_min"
    t.integer "apparent_temperature_min_time"
    t.float   "apparent_temperature_max"
    t.integer "apparent_temperature_max_time"
    t.float   "dew_point"
    t.float   "wind_speed"
    t.float   "wind_bearing"
    t.float   "cloud_cover"
    t.float   "humidity"
    t.float   "pressure"
    t.float   "visibility"
    t.float   "ozone"
    t.integer "fio_forecast_id"
    t.integer "fio_day_info_id"
    t.integer "summary_id"
    t.integer "icon_id"
  end

  add_index "fio_data", ["time"], name: "fio_data_time_idx"

  create_table "fio_day_info", force: :cascade do |t|
    t.integer "sunrise"
    t.integer "sunset"
    t.float   "moon_phase"
  end

  create_table "fio_forecast", force: :cascade do |t|
    t.integer "master_timestamp"
    t.integer "type_id"
    t.integer "summary_id"
    t.integer "icon_id"
  end

  add_index "fio_forecast", ["master_timestamp"], name: "fio_forecast_time_idx"

  create_table "fio_forecast_type", force: :cascade do |t|
    t.text "type"
  end

  add_index "fio_forecast_type", ["type"], name: "fio_forecast_type_idx"
  add_index "fio_forecast_type", ["type"], name: "sqlite_autoindex_fio_forecast_type_1", unique: true

  create_table "fio_icon", force: :cascade do |t|
    t.text "icon"
  end

  add_index "fio_icon", ["icon"], name: "fio_icon_idx"
  add_index "fio_icon", ["icon"], name: "sqlite_autoindex_fio_icon_1", unique: true

  create_table "fio_summary", force: :cascade do |t|
    t.text "summary"
  end

  add_index "fio_summary", ["summary"], name: "fio_summary_idx"
  add_index "fio_summary", ["summary"], name: "sqlite_autoindex_fio_summary_1", unique: true

  create_table "gh_data_points", force: :cascade do |t|
    t.integer "timestamp"
    t.integer "synchronized", default: 0
  end

  add_index "gh_data_points", ["timestamp"], name: "index_gh_data_points_on_timestamp"

  create_table "gh_image_data", force: :cascade do |t|
    t.text    "filename"
    t.integer "gh_data_point_id"
  end

  add_index "gh_image_data", ["gh_data_point_id"], name: "index_gh_image_data_on_gh_data_point_id"

  create_table "gh_sensor_data", force: :cascade do |t|
    t.integer "sensor_id"
    t.float   "temperature"
    t.float   "humidity"
    t.integer "gh_data_point_id"
  end

  add_index "gh_sensor_data", ["gh_data_point_id"], name: "index_gh_sensor_data_on_gh_data_point_id"

  create_table "gh_system_data", force: :cascade do |t|
    t.float   "soc_temperature"
    t.float   "wlan0_link_quality"
    t.integer "wlan0_signal_level"
    t.integer "storage_total_size"
    t.integer "storage_used"
    t.integer "storage_avail"
    t.integer "gh_data_point_id"
  end

  add_index "gh_system_data", ["gh_data_point_id"], name: "index_gh_system_data_on_gh_data_point_id"

  create_table "owm_city", force: :cascade do |t|
    t.text "name", default: "Unnamed Location"
  end

  create_table "owm_day_info", force: :cascade do |t|
    t.integer "sunrise"
    t.integer "sunset"
  end

  create_table "owm_detail", force: :cascade do |t|
    t.integer "dt"
    t.float   "main_temp_k"
    t.float   "main_temp_min_k"
    t.float   "main_temp_max_k"
    t.float   "main_pressure"
    t.float   "main_humidity"
    t.float   "clouds_percent"
    t.float   "wind_speed_mps"
    t.float   "wind_deg"
    t.float   "rain_vol_last_3h"
    t.float   "snow_last_3h"
    t.integer "days_since_epoch"
    t.integer "live_condition"
    t.integer "owm_day_id"
    t.integer "owm_city_id"
  end

  add_index "owm_detail", ["days_since_epoch"], name: "owm_detail_days_since_epoch_idx"
  add_index "owm_detail", ["dt"], name: "owm_detail_dt_idx"

  create_table "owm_detail_to_weather_map", force: :cascade do |t|
    t.integer "owm_detail_id"
    t.integer "owm_weather_id"
  end

  add_index "owm_detail_to_weather_map", ["owm_detail_id"], name: "owm_detail_to_weather_map_owm_detail_id_idx"
  add_index "owm_detail_to_weather_map", ["owm_weather_id"], name: "owm_detail_to_weather_map_owm_weather_id_idx"

  create_table "owm_weather", force: :cascade do |t|
    t.text "main"
    t.text "description"
    t.text "icon"
  end

  create_table "weather_meta_data", force: :cascade do |t|
    t.integer "timestamp"
    t.text    "note"
  end

end
