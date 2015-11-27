class SDKDuplicateRequestException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Duplicate request data'

		if message.is_a? Array
			message = message.map{ |el| '`' + el + '`' }.join(', ')
		end

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' - multiple ' + message
		end

		super
	end

end
