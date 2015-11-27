class PlatformBrowserVersionsHandler < EntityHandler

	def initialize(origin, browserID)
		super(origin)

		@browserID = browserID
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/browsers/' + @browserID.to_s() + '/versions', 'GET')
		EntityList.new(@origin, request, PlatformBrowserVersion, filters)
	end

end
