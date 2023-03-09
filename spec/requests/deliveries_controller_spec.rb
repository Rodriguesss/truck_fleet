require 'rails_helper'

RSpec.describe "DeliveriesControllers", type: :request do
  let(:delivery) { create(:delivery) }
  let(:uf_attributes) { { uf: { name: "MG" } } }
  let(:city_attributes) { { city: { name: "Uberlandia", uf_id: 1 } } }
  let(:delivery_attributes) { { delivery: { product_id: 1, travel_id: 1 } } }
  let(:attributes_another_city) { { city: { name: "Patrocinio", uf_id: 1 } } }
  let(:product_type_attributes) { { product_type: { description: "Tecnologia" } } }
  let(:truck_driver_attributes) { { truck_driver: { name: "Marcos Pereira", age: 32 } } }
  let(:product_attributes) { { product: { name: "Playstation 5", price: 5000, weight: "10.21",
    dimension: "11.02 X 24.84 X 64.12", description: "Um video game de ultima geração." } } }
  let(:travel_attributes) { { travel: { destination_date: "2023-02-28", date_of_origin: "2023-01-01",
    expected_date: "2023-03-01", origin_city_id: 1, destination_city_id: 2, truck_driver_id: 1,
    product_type_id: 1 } } }

  describe "GET /deliveries" do
    before { create_list(:delivery, 2) }

    it "return all deliveries" do
      get "/deliveries"
      expect(response).to have_http_status(:success)
      expect(Delivery.count).to eq(2)
    end
  end

  describe "POST /deliveries" do
    it "creates a new delivery" do
      expect {
        post "/ufs", params: uf_attributes
      }.to change(Uf, :count).by(1)

      expect {
        post "/cities", params: city_attributes
      }.to change(City, :count).by(1)

      expect {
        post "/cities", params: attributes_another_city
      }.to change(City, :count).by(1)

      expect {
        post "/truck_drivers", params: truck_driver_attributes
      }.to change(TruckDriver, :count).by(1)

      expect {
        post "/product_types", params: product_type_attributes
      }.to change(ProductType, :count).by(1)

      expect {
        post "/travels", params: travel_attributes
      }.to change(Travel, :count).by(1)

      expect {
        post "/products", params: product_attributes
      }.to change(Product, :count).by(1)

      expect {
        post "/deliveries", params: delivery_attributes
      }.to change(Delivery, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /deliveries/:id' do
    it 'returns the delivery' do
      get "/deliveries/#{delivery.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['travel_id']).to eq(delivery.travel_id)
      expect(JSON.parse(response.body)['product_id']).to eq(delivery.product_id)
    end

    context 'when the delivery does not exist' do
      it 'returns a not found message' do
        get "/deliveries/0"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Entrega não encontrada')
      end
    end
  end

  describe 'PUT /deliveries/:id' do
    let(:product_attributes) { { product: { name: "Playstation 4", price: 2000, weight: "8.21",
      dimension: "10.02 X 20.84 X 31.12", description: "Um video game." } } }

    context "when the delivery exists" do
      let(:new_delivery) { { delivery: { product_id: 2, travel_id: 1 } } }

      it "updates the delivery" do
        expect {
          post "/products", params: product_attributes
        }.to change(Product, :count).by(1)

        put "/deliveries/#{delivery.id}", params: new_delivery

        expect(response).to have_http_status(:ok)
        expect(response.body['travel_id']).to include(new_delivery.to_json['travel_id'])
        expect(response.body['product_id']).to include(new_delivery.to_json['product_id'])
      end
    end

    context "when the delivery does not exist" do
      it "returns a not found message" do
        put "/deliveries/0", params: { delivery: { name: "Patrocinio", uf_id: 1 } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Entrega não encontrada")
      end
    end
  end

  describe 'DELETE /deliveries/:id' do
    let!(:delivery) { create(:delivery) }

    context "when the delivery exists" do
      it "deletes the delivery" do
        expect {
          delete "/deliveries/#{delivery.id}"
        }.to change(Delivery, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the delivery does not exist" do
      it "returns a not found message" do
        delete "/deliveries/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Entrega não encontrada")
      end
    end
  end
end
