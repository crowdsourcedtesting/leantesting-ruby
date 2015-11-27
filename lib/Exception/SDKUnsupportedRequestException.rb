class SDKUnsupportedRequestException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Unsupported request data'

		if message.is_a? Array
			message = message.map{ |el| '`' + el + '`' }.join(', ')
		end

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' - invalid ' + message
		end

		super
	end

end
