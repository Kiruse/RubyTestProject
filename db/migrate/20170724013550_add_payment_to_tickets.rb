class AddPaymentToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :price, :decimal
    add_reference :tickets, :payment_options, foreign_key: true
  end
end
