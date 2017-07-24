module Api
	require 'date'
	
  class PaymentsController < ApplicationController
    def new
      @ticket = Ticket.find(params[:ticket_barcode])
      @paymentOptions = PaymentOption.all
    end
    
    def create
      @ticket = Ticket.find(params[:ticket_barcode])
      
      # Ensure the ticket exists
      head :not_found and return unless @ticket
      # Ensure the ticket has not yet been paid
      head :gone and return if @ticket[:redeemed]
      
      data = { payment_options_id: params[:payment][:payment_options_id], redeemed: DateTime.now }
      if @ticket.update(data)
      	redirect_to [:api, @ticket]
      else
      	head 500 and return
      end
    end
	end
end
