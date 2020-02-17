class Partner < ApplicationRecord
    validates :tradingName, :ownerName, presence: true
    validates :document, presence: true, uniqueness: true
    validates :coverageArea, presence: true
    validates :address, presence: true
    validate :coverageArea_must_be_a_hash
    validate :address_must_be_a_hash

    protected
    def coverageArea_must_be_a_hash
        if !self.coverageArea.kind_of?(Hash)
            errors.add(:coverageArea, "must be a hash")
        end
    end

    def address_must_be_a_hash
        if !self.address.kind_of?(Hash)
            errors.add(:address, "must be a hash")
        end
    end
end
