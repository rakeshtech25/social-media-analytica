# frozen_string_literal: true

class AnalyticsController < ApplicationController
  def index
    data = SocialMediaManager.run
    return render json: data.result if data.valid? && data.errors.messages.empty?

    render json: 'Something went wrong!', status: 500
  end
end
