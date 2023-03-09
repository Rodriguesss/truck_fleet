require 'rails_helper'

RSpec.describe "CitiesControllers", type: :request do
  let(:city) { create(:city) }
  let(:uf_attributes) { { uf: { name: "MG" } } }
  let(:city_attributes) { { city: { name: "Uberlandia", uf_id: 1 } } }

  describe "GET /cities" do
    before { create_list(:city, 4) }

    it "return all cities" do
      get "/cities"
      expect(response).to have_http_status(:success)
      expect(City.count).to eq(4)
    end
  end

  describe "POST /cities" do
    it "creates a new city" do
      expect {
        post "/ufs", params: uf_attributes
      }.to change(Uf, :count).by(1)

      expect {
        post "/cities", params: city_attributes
      }.to change(City, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Uberlandia')
      expect(JSON.parse(response.body)['uf_id']).to be_an(Integer)
    end
  end

  describe 'GET /cities/:id' do
    it 'returns the city' do
      get "/cities/#{city.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(city.name)
      expect(JSON.parse(response.body)['uf_id']).to eq(city.uf_id)
    end

    context 'when the city does not exist' do
      it 'returns a not found message' do
        get "/cities/0"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Cidade não encontrada')
      end
    end
  end

  describe 'PUT /cities/:id' do
    context "when the city exists" do
      let(:new_city) {{ city: { name: "Patrocinio", uf_id: 1 } }}

      it "updates the city" do
        put "/cities/#{city.id}", params: new_city

        expect(response).to have_http_status(:ok)
        expect(response.body['name']).to include(new_city.to_json['name'])
        expect(response.body['uf_id']).to include(new_city.to_json['uf_id'])
      end
    end

    context "when the city does not exist" do
      it "returns a not found message" do
        put "/cities/0", params: { city: { name: "Patrocinio", uf_id: 1 } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Cidade não encontrada")
      end
    end
  end

  describe 'DELETE /cities/:id' do
    let!(:city) { create(:city) }

    context "when the city exists" do
      it "deletes the city" do
        expect {
          delete "/cities/#{city.id}"
        }.to change(City, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the city does not exist" do
      it "returns a not found message" do
        delete "/cities/0"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Cidade não encontrada")
      end
    end
  end
end
