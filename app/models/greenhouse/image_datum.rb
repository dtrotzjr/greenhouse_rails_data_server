require 'date'

module Greenhouse
  class ImageDatum < ActiveRecord::Base
    include WeatherHelper
    belongs_to :greenhouse_data_point, class_name: 'Greenhouse::DataPoint'
    self.table_name = 'gh_image_data'

    def self.most_recent_image_name
      most_recent_data_point = Greenhouse::DataPoint.where(synchronized: 1).order('timestamp').last
      image_data = most_recent_data_point.greenhouse_image_data.first!
      full_path = image_data.filename
      local_path = 'imgs/2017/' + full_path.split('/').last
      return local_path
    end

    def self.most_recent_image_alt_text
      most_recent_data_point = Greenhouse::DataPoint.where(synchronized: 1).order('timestamp').last
      alt_text = Date.strptime("#{most_recent_data_point.timestamp}", "%s").strftime('%A, %B %_m, %Y at %l:%M %P')
      return alt_text
    end
  end
end

