require 'spec_helper'

describe ProductsController do
  render_views
  describe "index" do
    before do
      Product.create!(name: 'Football')
      Product.create!(name: 'Baseball Glove')
      Product.create!(name: 'Hockey Stick')
      Product.create!(name: 'Skateboard')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'ball' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Football'" do
        expect(results.map(&extract_name)).to include('Football')
      end
      it "should include 'Baseball Glove'" do
        expect(results.map(&extract_name)).to include('Baseball Glove')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'zzzzzzzzz' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: product_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the product exists" do
      let(:product) {
        Product.create!(name: 'Surfbaord',
               description: "6ft Fishtail",
               quantity:    2,
               price:       450,
               sku:         "CH-001"
               )
      }
      let(:product_id) { product.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(product.id) }
      it { expect(results["name"]).to eq(product.name) }
      it { expect(results["description"]).to eq(product.description) }
      it { expect(results["quantity"].to_i).to eq(product.quantity) }
      it { expect(results["price"].to_f).to be_within(0.5).of(product.price) }
      it { expect(results["sku"]).to eq(product.sku) }
    end

    context "when the product doesn't exist" do
      let(:product_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end

  describe "create" do
    before do
      xhr :post, :create, format: :json, product: { name: "Snow Shoes",
                                                    description: "Size 8, Mens",
                                                    quantity:    25,
                                                    price:       60,
                                                    sku:         "CH-103"
                                                  }
    end
    it { expect(response.status).to eq(201) }
    it {}

    it { expect(Product.last.name).to eq("Snow Shoes") }
    it { expect(Product.last.description).to eq("Size 8, Mens") }
    it { expect(Product.last.quantity.to_i).to eq(25) }
    it { expect(Product.last.price.to_f).to be_within(0.5).of(60) }
    it { expect(Product.last.sku).to eq("CH-103") }
  end

  describe "update" do
    let(:product) {
      Product.create!(name: "Skateboard",
                     description: "Element Trucks, Sector 9 Longboard Wheels, Zero American Punk Deck",
                     quantity:    1,
                     price:       85,
                     sku:         "CH-310"
                     )
    }
    before do
      xhr :put, :update, format: :json, id: product.id, product: { name: "Skateboard",
                                                                   description: "Element Trucks, Sector 9 Longboard Wheels, Zero American Punk Deck",
                                                                   quantity:    1,
                                                                   price:       85,
                                                                   sku:         "CH-310"
                                                                 }

      product.reload
    end
    it { expect(response.status).to eq(204) }
    it { expect(Product.last.name).to eq("Skateboard") }
    it { expect(Product.last.description).to eq("Element Trucks, Sector 9 Longboard Wheels, Zero American Punk Deck") }
    it { expect(Product.last.quantity.to_i).to eq(1) }
    it { expect(Product.last.price.to_f).to be_within(0.5).of(85) }
    it { expect(Product.last.sku).to eq("CH-310") }
  end

  describe "destroy" do

    let(:product_id) {
      Product.create!(name: "Skateboard",
                      description: "Element Trucks, Sector 9 Longboard Wheels, Zero American Punk Deck",
                      quantity:    1,
                      price:       85,
                      sku:         "CH-310").id
    }
    before do
      xhr :delete, :destroy, format: :json, id: product_id
    end
    it { expect(response.status).to eq(204) }
    it { expect(Product.find_by_id(product_id)).to be_nil }
  end
end
