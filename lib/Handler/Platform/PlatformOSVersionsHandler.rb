class PlatformOSVersionsHandler < EntityHandler

	def initialize(origin, osID)
		super(origin)

		@osID = osID
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/os/' + @osID.to_s() + '/versions', 'GET')
		EntityList.new(@origin, request, PlatformOSVersion, filters)
	end

end
