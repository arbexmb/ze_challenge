require 'rails_helper'
require 'rest-client'

RSpec.describe PartnersController, type: :controller do
    it "a partner can be created" do
        before_count = Partner.count
        post :create, params: {
            partner: {
                "tradingName": "Adega da Cerveja - Pinheiros",
                "ownerName": "Zé da Silva",
                "document": "1432132123891/0001",
                "coverageArea": { 
                    "type": "MultiPolygon", 
                    "coordinates": [
                        [
                            [
                                [30, 20], [45, 40], [10, 40], [30, 20]
                            ]
                        ], 
                        [
                            [
                                [15, 5], [40, 10], [10, 20], [5, 10], [15, 5]
                            ]
                        ]
                    ]
                },
                "address": { 
                    "type": "Point",
                    "coordinates": [-46.57421, -21.785741]
                },
            }
        }

        expect(response).to have_http_status(201)
        expect(Partner.count).not_to eq(before_count)
    end

    it "a partner can be fetched" do
        partner = create(:partner)
        get :show, params: { id: partner.id }
        expect(JSON.parse response.body).to include(partner.as_json)
    end

    it "multiple partners can be created" do
      response = RestClient.get 'https://raw.githubusercontent.com/ZXVentures/ze-code-challenges/master/files/pdvs.json'
      partners = JSON.parse response.body
      post :create, params: partners

      expect(Partner.count).to eq(51)
    end
end
