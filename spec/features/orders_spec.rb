require 'rails_helper'

RSpec.feature "Orders", type: :feature do

  describe 'device ordering process' do
    let(:facility) { create(:facility) }
    let(:user) { facility.users.take }
    let(:product) { create(:product) }

    before do
      login_as(user.email, attributes_for(:user)[:password])

      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getCities\",\"methodProperties\":{}}").
        to_return(status: 200, body: vcr_response('nova_poshta/cities'), headers: {})

      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getAreas\",\"methodProperties\":{}}").
        to_return(status: 200, body: vcr_response('nova_poshta/areas'), headers: {})

      stub_request(:post, "https://api.novaposhta.ua/v2.0/json/").
        with(body: "{\"apiKey\":\"ac1b36959b82784f9ed5dd1ec2719430\",\"modelName\":\"Address\",\"calledMethod\":\"getWarehouses\",\"methodProperties\":{\"CityRef\":\"8d5a980d-391c-11dd-90d9-001a92567626\"}}",).
        to_return(status: 200, body: vcr_response('nova_poshta/warehouses/kiev'), headers: {})
    end

    it 'works', js: true do
      product
      cart = user.cart
      visit facility_devices_path(facility)
      click_on :buy
      expect(page).to have_current_path(products_path)
      click_on "add_product_#{product.id}_to_cart"
      expect(page).to have_current_path(cart_path)
      click_on 'checkout'

      fill_in :order_delivery_attributes_full_name, with: 'John Doe'
      fill_in :order_delivery_attributes_email, with: 'j.doe@example.com'
      fill_in :order_delivery_attributes_phone, with: '0501234567'
      fill_in :order_comment, with: 'some comment'
      fill_in :city, with: 'Ки'
      wait_for_ajax

      page.all('.tt-suggestion')[1].click
      wait_for_ajax

      click_on 'checkout'
      expect(ActionMailer::Base.deliveries.count).to eq(1)

      order = cart.reload # now it's an order
      expect(page).to have_current_path(order_path(order))
      expect(order).to have_attributes({
        "status"=>"pending",
        "delivery_method"=>"nova_poshta",
        "payment_method"=>"liqpay",
        "paid"=>false,
        "comment"=>'some comment',
        "delivery_options"=>{
          "full_name"=>"John Doe",
          "phone"=>"0501234567",
          "email"=>"j.doe@example.com",
          "city"=>"Київ - Київська обл.",
          "city_ref"=>"8d5a980d-391c-11dd-90d9-001a92567626",
          "warehouse_ref"=>"1ec09d88-e1c2-11e3-8c4a-0050568002cf"
        }})

    end
  end
end
