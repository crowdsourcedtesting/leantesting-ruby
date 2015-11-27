class BugCommentsHandler < EntityHandler

	def initialize(origin, bugID)
		super(origin)

		@bugID = bugID
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/bugs/' + @bugID.to_s() + '/comments', 'GET')
		EntityList.new(@origin, request, BugComment, filters)
	end

end
