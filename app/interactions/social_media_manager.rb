# frozen_string_literal: true

class SocialMediaManager < ActiveInteraction::Base

  def execute
    response_hash = {}
    threads = []
    SOCIAL_MEDIA_HASH.to_h.each do |platform, object|
      threads << Thread.new do
        response_hash[platform] = RemoteRequest.get(platform)
      end
    end
    threads.each(&:join)

    response_hash
  end
end
