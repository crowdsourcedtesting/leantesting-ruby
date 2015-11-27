class SDKInvalidArgException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Invalid argument'

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ': ' + message
		end

		super
	end

end
