require 'rails_helper'

RSpec.describe "ProductsControllers", type: :request do
  let(:product) { create(:product) }
  let(:attributes) { { product: { name: "PS5", price: 5000 , weight: "2.52",
    dimension: "10.12 X 15.20 X 21.35", description: "Um video game da nova geração" } } }

  describe "GET /products" do
    before { create_list(:product, 2) }

    it "returns all products" do
      get "/products"
      expect(response).to have_http_status(:success)
      expect(Product.count).to eq(2)
    end
  end

  describe "POST /products" do
    it "creates a new product" do
      expect {
        post "/products", params: attributes
      }.to change(Product, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('PS5')
      expect(JSON.parse(response.body)['price']).to eq(5000)
      expect(JSON.parse(response.body)['weight']).to eq('2.52')
      expect(JSON.parse(response.body)['dimension']).to eq('10.12 X 15.20 X 21.35')
      expect(JSON.parse(response.body)['description']).to eq('Um video game da nova geração')
    end
  end

  describe 'GET /products/:id' do
    it 'returns the product' do
      get "/products/#{product.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(product.name)
      expect(JSON.parse(response.body)['price']).to eq(product.price)
      expect(JSON.parse(response.body)['weight']).to eq(product.weight)
      expect(JSON.parse(response.body)['dimension']).to eq(product.dimension)
      expect(JSON.parse(response.body)['description']).to eq(product.description)
    end

    context 'when the product does not exist' do
      it 'returns a not found message' do
        get "/products/9999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Produto não encontrado')
      end
    end
  end

  describe 'PUT /products/:id' do
    let(:new_product) {{ name: "PS4", price: 2000 , weight: "2.01",
      dimension: "10.09 X 11.01 X 15.78", description: "Um video game da antiga geração" }}

    context "when the product exists" do

      it "updates the product" do
        put "/products/#{product.id}", params: { product: new_product }

        expect(response).to have_http_status(:ok)
        expect(response.body['name']).to include(new_product.to_json['name'])
        expect(response.body['price']).to include(new_product.to_json['price'])
        expect(response.body['weight']).to include(new_product.to_json['weight'])
        expect(response.body['dimension']).to include(new_product.to_json['dimension'])
        expect(response.body['description']).to include(new_product.to_json['description'])
      end
    end

    context "when the product does not exist" do
      it "returns a not found message" do
        put "/products/9999", params: new_product

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Produto não encontrado")
      end
    end
  end

  describe 'DELETE /products/:id' do
    let!(:product) { create(:product) }

    context "when the product exists" do
      it "deletes the product" do
        expect {
          delete "/products/#{product.id}"
        }.to change(Product, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the product does not exist" do
      it "returns a not found message" do
        delete "/products/9999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Produto não encontrado")
      end
    end
  end
end
