class SDKBadJSONResponseException < SDKException

	def initialize(message = nil)
		@baseMessage = 'JSON remote response is inconsistent or invalid'

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' - ' + message
		end

		super
	end

end
