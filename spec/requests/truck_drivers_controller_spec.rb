require 'rails_helper'

RSpec.describe "TruckDriversControllers", type: :request do
  let(:truck_driver) { create(:truck_driver) }
  let(:attributes) { { truck_driver: { name: "Marcos Pereira", age: 32 } } }

  describe "GET /truck_drivers" do
    before { create_list(:truck_driver, 3) }

    it "return all truck drivers" do
      get "/truck_drivers"
      expect(response).to have_http_status(:success)
      expect(TruckDriver.count).to eq(3)
    end
  end

  describe "POST /truck_drivers" do
    it "creates a new truck driver" do
      expect {
        post "/truck_drivers", params: attributes
      }.to change(TruckDriver, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Marcos Pereira')
      expect(JSON.parse(response.body)['age']).to be_an(Integer)
    end
  end

  describe 'GET /truck_drivers/:id' do
    it 'returns the truck_driver' do
      get "/truck_drivers/#{truck_driver.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(truck_driver.name)
      expect(JSON.parse(response.body)['age']).to eq(truck_driver.age)
    end

    context 'when the truck driver does not exist' do
      it 'returns a not found message' do
        get "/truck_drivers/9999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Motorista de caminhão não encontrado')
      end
    end
  end

  describe 'PUT /truck_drivers/:id' do
    context "when the truck driver exists" do
      let(:new_truck_driver) {{ name: "João Paulo", age: 24 }}

      it "updates the truck driver" do
        put "/truck_drivers/#{truck_driver.id}", params: { truck_driver: new_truck_driver }

        expect(response).to have_http_status(:ok)
        expect(response.body['name']).to include(new_truck_driver.to_json['name'])
        expect(response.body['age']).to include(new_truck_driver.to_json['age'])
      end
    end

    context "when the truck driver does not exist" do
      it "returns a not found message" do
        put "/truck_drivers/9999", params: { truck_driver: { name: "Thiago Santos", age: 54 } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Motorista de caminhão não encontrado")
      end
    end
  end

  describe 'DELETE /truck_drivers/:id' do
    let!(:truck_driver) { create(:truck_driver) }

    context "when the truck driver exists" do
      it "deletes the truck driver" do
        expect {
          delete "/truck_drivers/#{truck_driver.id}"
        }.to change(TruckDriver, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the truck driver does not exist" do
      it "returns a not found message" do
        delete "/truck_drivers/9999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Motorista de caminhão não encontrado")
      end
    end
  end
end

