class SDKMissingArgException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Missing argument'

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' `' + message + '`'
		end

		super
	end

end
