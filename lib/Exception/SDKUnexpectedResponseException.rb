class SDKUnexpectedResponseException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Got unexpected remote response'

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' - ' + message
		end

		super
	end

end
