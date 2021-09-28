# frozen_string_literal: true

module SocialMedia
  module Api
    class Request
      attr_reader :platform

      def initialize(platform)
        @platform = platform     
      end

      def self.get(*args, &block)
        new(*args, &block).get
      end


      def get
        url = "#{ENV['BASE_URL']}/#{platform}"
        response = HTTParty.get(url, { timeout: 10 })

        case response.code
        when 200
          extract_data(response)
        when 404
          'Data not found!'
        when 500...600
          "ERROR #{response.code}"
        else
          'Something went wrong!'
        end

      rescue Net::OpenTimeout, Net::ReadTimeout
        'Connection timed out!'
      end

      private

      def extract_data(response)
        object = SOCIAL_MEDIA_HASH[platform.to_sym]
        filtered_data = JSON.parse(response.body).map { |res| res[object] }.compact

        return filtered_data if filtered_data.present?

        "Response Error!"
      end
    end
  end
end