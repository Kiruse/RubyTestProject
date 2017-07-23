module Api
  require 'securerandom'
  
  class TicketsController < ApplicationController
    MAX_TICKETS = 100
    
    def index
      # Pass the maximum number of tickets to the view
      @max_tickets = MAX_TICKETS
      
      # Count the currently active tickets
      @active_tickets = Ticket.where(redeemed: nil).count
    end
    
    def create
      @Ticket = Ticket.new(redeemed: nil, barcode: SecureRandom.hex(16))
      
      @Ticket.save
      redirect_to [:api, @Ticket]
    end
    
    def new
    end
    
    def edit
    end
    
    def show
      @Ticket = Ticket.find(params[:id])
    end
    
    def update
    end
    
    def destroy
    end
  end
end
