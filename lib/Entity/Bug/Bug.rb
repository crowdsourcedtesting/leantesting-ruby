class Bug < Entity
	attr_reader :comments, :attachments

	def initialize(origin, data)
		super

		@comments		= BugCommentsHandler.new(origin, data['id'])
		@attachments	= BugAttachmentsHandler.new(origin, data['id'])
	end

end
