require 'rails_helper'

RSpec.describe "ProductTypesControllers", type: :request do
  let(:product_type) { create(:product_type) }
  let(:attributes) { { product_type: { description: "Tecnologia" } } }

  describe "GET /product_types" do
    before { create_list(:product_type, 3) }

    it "returns all product types" do
      get "/product_types"
      expect(response).to have_http_status(:success)
      expect(ProductType.count).to eq(3)
    end
  end

  describe "POST /product_types" do
    it "creates a new product type" do
      expect {
        post "/product_types", params: attributes
      }.to change(ProductType, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['description']).to eq('Tecnologia')
    end
  end

  describe 'GET /product_types/:id' do
    it 'returns the product type' do
      get "/product_types/#{product_type.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['description']).to eq(product_type.description)
    end

    context 'when the product type does not exist' do
      it 'returns a not found message' do
        get "/product_types/9999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Tipo de produto não encontrado')
      end
    end
  end

  describe 'PUT /product_types/:id' do
    context "when the product type exists" do
      let(:new_product_type) { "Alimento" }

      it "updates the product type" do
        put "/product_types/#{product_type.id}", params: { product_type: { description: new_product_type } }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(new_product_type)
      end
    end

    context "when the product type does not exist" do
      it "returns a not found message" do
        put "/product_types/9999", params: { product_type: { description: "Moveis" } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Tipo de produto não encontrado")
      end
    end
  end

  describe 'DELETE /product_types/:id' do
    let!(:product_type) { create(:product_type) }

    context "when the product type exists" do
      it "deletes the product type" do
        expect {
          delete "/product_types/#{product_type.id}"
        }.to change(ProductType, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the product type does not exist" do
      it "returns a not found message" do
        delete "/product_types/9999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Tipo de produto não encontrado")
      end
    end
  end
end
