class Partner < ApplicationRecord
    validates :tradingName, :ownerName, presence: true
    validates :document, presence: true, uniqueness: true
    validates :coverageArea, presence: true
    validates :address, presence: true
    validate :coverageArea_must_be_an_array
    validate :address_must_be_a_hash

    protected
    def coverageArea_must_be_an_array
        if !self.coverageArea.kind_of?(Array)
            errors.add(:coverageArea, "must be an array")
        end
    end

    def address_must_be_a_hash
        if !self.address.kind_of?(Hash)
            errors.add(:address, "must be a hash")
        end
    end
end
