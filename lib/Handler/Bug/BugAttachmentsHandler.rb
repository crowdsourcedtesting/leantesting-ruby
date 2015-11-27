class BugAttachmentsHandler < EntityHandler

	def initialize(origin, bugID)
		super(origin)

		@bugID = bugID
	end

	#
	# Uploads given file as an attachment for specified bug.
	#
	# Arguments:
	#	filepath String -- an absolute path of the file to be uploaded
	#					example: /home/path/to/file.txt (Linux), C:\\Users\\Documents\\file.txt (Windows)
	#
	# Exceptions:
	#	SDKInvalidArgException if filepath is not a string
	#
	# Returns:
	#	BugAttachment -- the newly uploaded attachment
	#
	def upload(filepath)
		if !filepath.is_a? String
			raise SDKInvalidArgException, '`filepath` must be of type string'
		end

		req = APIRequest.new(
			@origin,
			'/v1/bugs/' + @bugID.to_s() + '/attachments',
			'POST',
			{
				'form_data' => true,
				'file_path' => filepath
			}
		)

		BugAttachment.new(@origin, req.exec)
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/bugs/' + @bugID.to_s() + '/attachments', 'GET')
		EntityList.new(@origin, request, BugAttachment, filters)
	end

end
