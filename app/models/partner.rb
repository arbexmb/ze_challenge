class Partner < ApplicationRecord
    validates :tradingName, :ownerName, presence: true
    validates :document, presence: true, uniqueness: true
    validates :coverageArea, presence: true
    validates :address, presence: true
    validate :coverageArea_must_be_array
    validate :address_must_be_hash

    protected
    def coverageArea_must_be_array
        self.errors.add :coverageArea, "must be array" unless self.coverageArea.is_a? Array
    end

    def address_must_be_hash
        self.errors.add :address, "must be hash" unless self.address.is_a? Hash
    end
end
