require 'rails_helper'

RSpec.describe NovaPoshtaService do
  let(:nova_poshta) { NovaPoshtaService.new }

  describe '#cities', vcr: "nova_poshta_cities" do
    it do
      expect(nova_poshta.cities.first).to include({"Description"=>"Авангард"})
    end
  end

  describe '#areas', vcr: "nova_poshta_areas" do
    it do
      expect(nova_poshta.areas.first).to include("Description" => "АРК")
    end
  end

  describe '#warehouses', vcr: "nova_poshta_warehouses" do
    it do
      # Киев - 8d5a980d-391c-11dd-90d9-001a92567626
      expect(nova_poshta.warehouses('8d5a980d-391c-11dd-90d9-001a92567626').first).to include("Description" => "Відділення №1: вул. Пирогівський шлях, 135")
    end
  end
end
