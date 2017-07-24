class ReplaceRedeemedInTickets < ActiveRecord::Migration[5.1]
  def change
  	remove_column :tickets, :redeemed
  	add_column :tickets, :redeemed, :datetime
  end
end
