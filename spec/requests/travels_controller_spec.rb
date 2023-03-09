require 'rails_helper'

RSpec.describe "TravelsControllers", type: :request do
  let(:travel) { create(:travel) }
  let(:uf_attributes) { { uf: { name: "MG" } } }
  let(:city_attributes) { { city: { name: "Uberlandia", uf_id: 1 } } }
  let(:attributes_another_city) { { city: { name: "Patrocinio", uf_id: 1 } } }
  let(:product_type_attributes) { { product_type: { description: "Tecnologia" } } }
  let(:truck_driver_attributes) { { truck_driver: { name: "Marcos Pereira", age: 32 } } }
  let(:travel_attributes) { { travel: { destination_date: "2023-02-28",
    date_of_origin: "2023-01-01", expected_date: "2023-03-01",
    origin_city_id: 1, destination_city_id: 2, truck_driver_id: 1,
    product_type_id: 1 } } }

  describe "GET /travels" do
    before { create_list(:travel, 2) }

    it "returns all travels" do
      get "/travels"
      expect(response).to have_http_status(:success)
      expect(Travel.count).to eq(2)
    end
  end

  describe "POST /travels" do
    it "creates a new travel" do
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

      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /travels/:id' do
    it 'returns the travel' do
      get "/travels/#{travel.id}"
      expect(response).to have_http_status(:success)
      expect(Date.parse(JSON.parse(response.body)['destination_date'])).to eq(travel.destination_date)
      expect(Date.parse(JSON.parse(response.body)['date_of_origin'])).to eq(travel.date_of_origin)
      expect(Date.parse(JSON.parse(response.body)['expected_date'])).to eq(travel.expected_date)
      expect(JSON.parse(response.body)['origin_city_id']).to eq(travel.origin_city_id)
      expect(JSON.parse(response.body)['destination_city_id']).to eq(travel.destination_city_id)
      expect(JSON.parse(response.body)['truck_driver_id']).to eq(travel.truck_driver_id)
      expect(JSON.parse(response.body)['product_type_id']).to eq(travel.product_type_id)
    end

    context 'when the product does not exist' do
      it 'returns a not found message' do
        get "/travels/9999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Viagem não encontrada')
      end
    end
  end

  describe 'PUT /travels/:id' do
    let(:new_travel) {{ travel: { destination_date: "2023-03-01",
      date_of_origin: "2023-01-10", expected_date: "2023-03-02",
      origin_city_id: 1, destination_city_id: 2, truck_driver_id: 1,
      product_type_id: 1 } }}

    context "when the travel exists" do
      it "updates the travel" do
        put "/travels/#{travel.id}", params: new_travel

        expect(response).to have_http_status(:ok)
        expect(response.body['destination_date']).to include(new_travel.to_json['destination_date'])
        expect(response.body['date_of_origin']).to include(new_travel.to_json['date_of_origin'])
        expect(response.body['expected_date']).to include(new_travel.to_json['expected_date'])
        expect(response.body['origin_city_id']).to include(new_travel.to_json['origin_city_id'])
        expect(response.body['destination_city_id']).to include(new_travel.to_json['destination_city_id'])
        expect(response.body['truck_driver_id']).to include(new_travel.to_json['truck_driver_id'])
        expect(response.body['product_type_id']).to include(new_travel.to_json['product_type_id'])
      end
    end

    context "when the travel does not exist" do
      it "returns a not found message" do
        put "/travels/0", params: new_travel

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Viagem não encontrada")
      end
    end
  end

  describe 'DELETE /travels/:id' do
    let!(:travel) { create(:travel) }

    context "when the travel exists" do
      it "deletes the travel" do
        expect {
          delete "/travels/#{travel.id}"
        }.to change(Travel, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the travel does not exist" do
      it "returns a not found message" do
        delete "/travels/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Viagem não encontrada")
      end
    end
  end
end
