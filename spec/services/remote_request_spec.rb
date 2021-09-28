require 'rails_helper'

describe RemoteRequest do

  let(:complete_data) do
    {
      twitter: %w[one-tweet two-tweet],
      facebook: %w[one-status two-status],
      instagram: %w[one-photo two-photo]
    }
  end

  describe 'get' do
    context 'when platform is facebook' do
      subject { described_class.get('facebook') }
      let(:url) { "#{ ENV['FEED_BASE_URL'] }/facebook" }
      let(:fb_body) { [{ name: 'name1', status: 'one-status' }, { name: 'name2', status: 'two-status' }] }
      let(:fb_response) { { status: 200, body: fb_body.to_json } }

      before do
        stub_request(:get, 'https://takehome.io/facebook')
          .with(headers: { 'Accept' => '*/*' })
          .to_return(fb_response)
      end

      it 'returns correct data in response' do
        expect(subject).to eq complete_data[:facebook]
      end
    end

    context 'when platform is instagram' do
      subject { described_class.get('instagram') }
      let(:url) { "#{ ENV['FEED_BASE_URL'] }/instagram" }
      let(:insta_body) { [{ name: 'name1', picture: 'one-photo' }, { name: 'name2', picture: 'two-photo' }] }
      let(:insta_response) { { status: 200, body: insta_body.to_json } }

      before do
        stub_request(:get, 'https://takehome.io/instagram')
          .with(headers: { 'Accept' => '*/*' })
          .to_return(insta_response)
      end

      it 'returns correct data in response' do
        expect(subject).to eq complete_data[:instagram]
      end
    end

    context 'when platform is twitter' do
      subject { described_class.get('twitter') }
      let(:url) { "#{ ENV['FEED_BASE_URL'] }/twitter" }
      let(:tweet_body) { [{ name: 'name1', tweet: 'one-tweet' }, { name: 'name2', tweet: 'two-tweet' }] }
      let(:tweet_response) { { status: 200, body: tweet_body.to_json } }

      before do
        stub_request(:get, 'https://takehome.io/twitter')
          .with(headers: { 'Accept' => '*/*' })
          .to_return(tweet_response)
      end

      it 'returns correct data in response' do
        expect(subject).to eq complete_data[:twitter]
      end
    end
  end
end
