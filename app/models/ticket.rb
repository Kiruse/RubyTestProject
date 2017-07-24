require 'date'

class Ticket < ApplicationRecord
	validates :barcode, presence: true, length: { is: 16 }
	after_initialize :init
	
	has_one :paymentoption
	
	def init
		self.price ||= self.new_record?? 2 : Api::PaymentsHelper.calculate_price(self.created_at.to_datetime, DateTime.now)
	end
	
	def may_leave?
		# 24 * 4 = 96 quarter hours per day
		self[:redeemed] && ((DateTime.now - self[:redeemed].to_datetime) * 96) <= 1
	end
	
	def to_param
		self[:barcode].upcase
	end
	
	def self.find(barcode)
		Ticket.where(barcode: barcode.downcase).order(created_at: :desc).limit(1).first
	end
end
