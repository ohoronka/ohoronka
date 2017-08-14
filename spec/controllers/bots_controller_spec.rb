require 'rails_helper'

RSpec.describe BotsController, type: :controller do
  describe '#telegram' do
    let(:channel) { create(:telegram_channel) }
    let(:params) do
      {"update_id"=>763000557, "message"=>{"message_id"=>11, "from"=>{"id"=>429212655, "first_name"=>"Bogdan", "last_name"=>"Guban", "language_code"=>"en-US"}, "chat"=>{"id"=>429212655, "first_name"=>"Bogdan", "last_name"=>"Guban", "type"=>"private"}, "date"=>1502641159, "text"=>"/start #{channel.auth_token}", "entities"=>[{"type"=>"bot_command", "offset"=>0, "length"=>6}]}, "session"=>{"update_id"=>763000557, "message"=>{"message_id"=>11, "from"=>{"id"=>429212655, "first_name"=>"Bogdan", "last_name"=>"Guban", "language_code"=>"en-US"}, "chat"=>{"id"=>429212655, "first_name"=>"Bogdan", "last_name"=>"Guban", "type"=>"private"}, "date"=>1502641159, "text"=>"/start cqbMkutZoDbwV2q6a3JsfA", "entities"=>[{"type"=>"bot_command", "offset"=>0, "length"=>6}]}}}
    end

    it 'renders 404' do
      expect{
        post :telegram, params: params.merge(bot_token: 'wrong_token')
      }.to raise_error
    end

    it 'activates the channel' do
      expect_any_instance_of(Telegram::Bot::Api).to receive(:call)
      post :telegram, params: params.merge(bot_token: Telegram::CONFIG[:token])
      expect(response).to have_http_status(:ok)
      channel.reload
      expect(channel.identifier).to eq('429212655')
    end
  end
end
