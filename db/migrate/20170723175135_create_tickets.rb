class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :barcode
      t.date :redeemed

      t.timestamps
    end
  end
end
