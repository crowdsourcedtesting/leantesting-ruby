class SDKErrorResponseException < SDKException

	def initialize(message = nil)
		if !message
			message = 'Unknown remote error'
		else
			message = 'Got error response: ' + message
		end

		super
	end

end
