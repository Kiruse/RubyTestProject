module Api
	module PaymentsHelper
		require 'date'
		
		def calculate_price(start_date, end_date)
			# Sanitize arguments
			if (!start_date.is_a?(DateTime) && !end_date.is_a?(DateTime)) || (end_date < start_date)
				Float::NAN
			else
				# Time difference is in days, so 24 hours per day yields the time difference in hours,
				# followed by 2Eur per hour yields an effective price factor of 48. Floor that to only
				# calculate the price for begun hours.
				(((end_date - start_date) * 24).floor + 1) * 2
			end
		end
		module_function :calculate_price
	end
end
