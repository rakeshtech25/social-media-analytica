# frozen_string_literal: true

require 'rails_helper'

describe AnalyticsController, type: :controller do
  let(:complete_data) do
    {
      twitter: %w[one-tweet two-tweet],
      facebook: %w[one-status two-status],
      instagram: %w[one-photo two-photo]
    }
  end

  let(:incomplete_data) do
    {
      twitter: %w[one-tweet two-tweet],
      facebook: 'Response Error!',
      instagram: %w[one-photo two-photo]
    }
  end

  describe 'GET index' do
    context 'when result is success' do
      before do
        expect_any_instance_of(SocialMediaManager).to receive(:execute).once.and_return(media_response)
        get :index
      end

      context 'when complete data' do
        let(:media_response) do
          smm_instance = SocialMediaManager.new
          smm_instance.result = complete_data
        end

        it 'returns fetched data' do
          expect(response.body).to eq complete_data.to_json
        end

        it 'responds with 200' do
          expect(response.code).to eq '200'
        end
      end

      context 'when incomplete data' do
        let(:media_response) do
          smm_instance = SocialMediaManager.new
          smm_instance.result = incomplete_data
        end

        it 'returns fetched data' do
          expect(response.body).to eq incomplete_data.to_json
        end

        it 'responds with 200' do
          expect(response.code).to eq '200'
        end
      end
    end

    context 'when result is failure' do
      before do
        SocialMediaManager.stub_chain(:run, :valid?).and_return(false)
        get :index
      end

      let(:error) { 'Something went wrong!' }

      it 'returns error' do
        expect(response.body).to eq error
      end

      it 'responds with 500' do
        expect(response.code).to eq '500'
      end
    end
  end
end
