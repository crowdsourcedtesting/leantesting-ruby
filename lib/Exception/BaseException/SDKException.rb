class SDKException < Exception

	def initialize(message = nil)
		super

		if !message
			message = 'Unknown SDK Error'
		else
			message = 'SDK Error: ' + message
		end

		@message = message
	end

	def message
		@message
	end

end
