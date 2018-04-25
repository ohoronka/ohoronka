require 'rails_helper'

RSpec.feature "Products", type: :feature do
  let(:user) { create(:user, admin: true) }
  before { login_as(user.email, 'password') }

  describe 'product creation' do
    let(:product_attr) { attributes_for(:product).except(:id, :created_at, :updated_at, :image) }

    it 'creates a new product' do
      visit admin_products_path
      click_on(class: 'btn-new')
      expect(page).to have_current_path(new_admin_product_path)
      product_attr.each do |key, value|
        fill_in "product_#{key}", with: value
      end
      attach_file('product_image', Rails.root + 'spec/fixtures/device.png')
      expect{
        click_on t('actions.save')
      }.to change(Product, :count).by(1)

      product = Product.take
      expect(product).to have_attributes(product_attr)
      expect(File.exists?(Rails.root.to_s + '/public' + product.image.url)).to be_truthy
    end
  end

  describe 'product update' do
    let(:product_attr) { attributes_for(:product).except(:id, :created_at, :updated_at, :image).transform_values{|v| v * 2} }
    let!(:product) { create(:product) }

    it 'updates the product' do
      visit admin_products_path
      click_on(class: 'btn-edit')
      expect(page).to have_current_path(edit_admin_product_path(product))

      product_attr.each do |key, value|
        fill_in "product_#{key}", with: value
      end
      click_on t('actions.save')

      expect(page).to have_current_path(admin_products_path)
      expect(product.reload).to have_attributes(product_attr)
    end
  end

  describe 'destroying the product' do
    let!(:product) { create(:product) }

    it 'removes the product' do
      visit admin_products_path

      expect{
        click_on(class: 'btn-destroy')
      }.to change(Product, :count).by(-1)
    end
  end
end
