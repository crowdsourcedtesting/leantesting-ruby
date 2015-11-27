class PlatformTypeDevicesHandler < EntityHandler

	def initialize(origin, typeID)
		super(origin)

		@typeID = typeID
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/types/' + @typeID.to_s() + '/devices', 'GET')
		EntityList.new(@origin, request, PlatformDevice, filters)
	end

end
