require 'date'

module Greenhouse
  class ImageDatum < ActiveRecord::Base
    include WeatherHelper
    belongs_to :greenhouse_data_point, class_name: 'Greenhouse::DataPoint'
    self.table_name = 'gh_image_data'

    def self.most_recent_image_name
      most_recent_record = Greenhouse::ImageDatum.order('gh_data_point_id').last
      full_path = most_recent_record.filename
      local_path = 'imgs/2017/' + full_path.split('/').last
      return local_path
    end

    def self.most_recent_image_alt_text
      most_recent_record = Greenhouse::ImageDatum.order('gh_data_point_id').last
      gh_dp = Greenhouse::DataPoint.where(id: most_recent_record.gh_data_point_id).first!
      alt_text = Date.strptime("#{gh_dp.timestamp}", "%s").strftime('%A, %B %_m, %Y at %l:%M %P')
      return alt_text
    end
  end
end

