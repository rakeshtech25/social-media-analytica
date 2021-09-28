# frozen_string_literal: true

class RemoteRequest

	def self.get(platform)
		url = "#{ENV['BASE_URL']}/#{platform}"
    response = HTTParty.get(url)
    object = SOCIAL_MEDIA_HASH[platform.to_sym]

    case response.code
    when 200
      extract_data(response, object)
    when 404
      "Data not found!"
    when 500...600
      "ERROR #{response.code}"
    else
    	"Something went wrong!"
    end
  end

	private

  def self.extract_data(response, object)
    filtered_data = JSON.parse(response.body).map{|res| res[object] }.compact

    return filtered_data if filtered_data.present?

    "Response Error!"
  end
end
