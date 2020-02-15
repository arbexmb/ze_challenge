FactoryBot.define do
    factory :partner do
        tradingName { Faker::Company.industry }
        ownerName { Faker::Name.name }
        document { Faker::IDNumber.brazilian_id(formatted: true) }
        coverageArea { Array.new }
        address { {
            type: "Point",
            coordinates: [
                Faker::Address.latitude,
                Faker::Address.longitude
            ]
        } }
    end
end