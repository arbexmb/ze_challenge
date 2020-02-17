FactoryBot.define do
    factory :partner do
        tradingName { Faker::Company.industry }
        ownerName { Faker::Name.name }
        document { Faker::IDNumber.brazilian_id(formatted: true) }
        coverageArea { [
            [
                [
                    Faker::Address.latitude,
                    Faker::Address.longitude    
                ],
                [
                    Faker::Address.latitude,
                    Faker::Address.longitude    
                ],
                [
                    Faker::Address.latitude,
                    Faker::Address.longitude    
                ],
                [
                    Faker::Address.latitude,
                    Faker::Address.longitude    
                ],
            ]
        ] }
        address { {
            type: "Point",
            coordinates: [
                Faker::Address.latitude,
                Faker::Address.longitude
            ]
        } }
    end
end