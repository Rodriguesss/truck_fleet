require 'rails_helper'

RSpec.describe "UfsControllers", type: :request do
  let(:uf) { create(:uf) }
  let(:attributes) { { uf: { name: "MG" } } }

  describe "GET /ufs" do
    before { create_list(:uf, 5) }

    it "returns all ufs" do
      get "/ufs"
      expect(response).to have_http_status(:success)
      expect(Uf.count).to eq(5)
    end
  end

  describe "POST /ufs" do
    it "creates a new uf" do
      expect {
        post "/ufs", params: attributes
      }.to change(Uf, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('MG')
    end
  end

  describe 'GET /ufs/:id' do
    it 'returns the uf' do
      get "/ufs/#{uf.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(uf.name)
    end

    context 'when the uf does not exist' do
      it 'returns a not found message' do
        get "/ufs/9999"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Uf não encontrada')
      end
    end
  end

  describe 'PUT /ufs/:id' do
    context "when the uf exists" do
      let(:new_uf) { "SP" }

      it "updates the uf" do
        put "/ufs/#{uf.id}", params: { uf: { name: new_uf } }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(new_uf)
      end
    end

    context "when the uf does not exist" do
      it "returns a not found message" do
        put "/ufs/9999", params: { uf: { name: "RJ" } }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Uf não encontrada")
      end
    end
  end

  describe 'DELETE /ufs/:id' do
    let!(:uf) { create(:uf) }

    context "when the uf exists" do
      it "deletes the uf" do
        expect {
          delete "/ufs/#{uf.id}"
        }.to change(Uf, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the uf does not exist" do
      it "returns a not found message" do
        delete "/ufs/9999"

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("Uf não encontrada")
      end
    end
  end
end
