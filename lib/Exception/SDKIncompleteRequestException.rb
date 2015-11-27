class SDKIncompleteRequestException < SDKException

	def initialize(message = nil)
		@baseMessage = 'Incomplete request data'

		if message.is_a? Array
			message = message.map{ |el| '`' + el + '`' }.join(', ')
		end

		if !message
			message = @baseMessage
		else
			message = @baseMessage + ' - missing required ' + message
		end

		super
	end

end
