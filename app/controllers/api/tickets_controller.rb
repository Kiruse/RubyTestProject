module Api
  require 'securerandom'
  
  class TicketsController < ApplicationController
    MAX_TICKETS = 100
    
    def index
      # Pass the maximum number of tickets to the view
      @max_tickets = MAX_TICKETS
      
      # Count the currently active tickets
      @active_tickets = Ticket.active.count
    end
    
    def create
      # Prevent requesting a new ticket if no more free spaces
      head :forbidden and return if Ticket.active.count <= 0
      
      # Create new, unpaid ticket (make sure barcode case is enforced)
      @ticket = Ticket.new(redeemed: nil, barcode: SecureRandom.hex(8).downcase, payment_options_id: 0)
      
      if @ticket.save
        redirect_to [:api, @ticket]
      else
        head 500
      end
    end
    
    def new
    end
    
    def show
      # Just in the extremely rare case that two tickets have the same barcode, order by the creation time, newest first
      # Since we only have 100 tickets, the chance that any two of these tickets have the same barcode are atomically little
      @ticket = Ticket.find(params[:barcode])
      
      # Ensure the ticket exists
      head :not_found and return unless @ticket
      
      # If the ticket has not yet been paid, calculate and display the due price instead
      if !@ticket[:redeemed]
        @ticket[:price] = PaymentsHelper.calculate_price(@ticket[:created_at].to_datetime, DateTime.now)
      end
    end
    
    def free_spaces
      @free_spaces = MAX_TICKETS - Ticket.active.count
    end
  end
end
