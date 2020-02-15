class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :tradingName
      t.string :ownerName
      t.string :document
      t.jsonb :coverageArea
      t.jsonb :address

      t.timestamps
    end
  end
end
