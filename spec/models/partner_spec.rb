require 'rails_helper'

RSpec.describe Partner, type: :model do
    it "building a partner" do
        partner = build(:partner)
        expect(partner).to be_a(Partner)
    end

    context "validations" do
        it "tradingName is required" do
            is_expected.to validate_presence_of(:tradingName)
        end

        it "ownerName is required" do
            is_expected.to validate_presence_of(:ownerName)
        end

        it "document is required" do
            is_expected.to validate_presence_of(:document)
        end

        it "document must be unique" do
            is_expected.to validate_uniqueness_of(:document)
        end

        context "coverageArea" do
            it "coverageArea is required" do
                is_expected.to validate_presence_of(:coverageArea)
            end

            it "coveragaArea must be a hash" do
                partner = build(:partner, coverageArea: "String")
                partner.valid?
                expect(partner.errors['coverageArea']).to include("must be a hash")
            end

            # it "coverageArea cannot be nil" do
                
            # end
        end

        context "address" do
            it "address is required" do
                is_expected.to validate_presence_of(:address)
            end

            it "address must be a hash" do
                partner = build(:partner, address: "String")
                partner.valid?
                expect(partner.errors['address']).to include('must be a hash')
            end
        end
    end

    it "get partner by id" do

    end
end
