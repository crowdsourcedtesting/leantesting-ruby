class PlatformTypesHandler < EntityHandler

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/platform/types', 'GET')
		EntityList.new(@origin, request, PlatformType, filters)
	end

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/platform/types/' + id.to_s(), 'GET')
		PlatformType.new(@origin, req.exec)
	end

end
