require 'rails_helper'

RSpec.describe NovaPoshtaService do
  let(:nova_poshta) { NovaPoshtaService.new }

  describe '#cities' do
    before do
      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getCities\",\"methodProperties\":{}}").
        to_return(status: 200, body: vcr_response('nova_poshta/cities'), headers: {})
    end

    it do
      expect(nova_poshta.cities.first).to include({"Description"=>"Авангард"})
    end
  end

  describe '#areas' do
    before do
      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getAreas\",\"methodProperties\":{}}").
        to_return(status: 200, body: vcr_response('nova_poshta/areas'), headers: {})
    end

    it do
      expect(nova_poshta.areas.first).to include("Description" => "АРК")
    end
  end

  describe '#warehouses' do
    before do
      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getWarehouses\",\"methodProperties\":{\"CityRef\":\"8d5a980d-391c-11dd-90d9-001a92567626\"}}",).
        to_return(status: 200, body: vcr_response('nova_poshta/warehouses/kiev'), headers: {})
    end

    it do
      # Киев - 8d5a980d-391c-11dd-90d9-001a92567626
      expect(nova_poshta.warehouses('8d5a980d-391c-11dd-90d9-001a92567626').first).to include("Description" => "Відділення №1: вул. Пирогівський шлях, 135")
    end
  end
end
