class PlatformBrowsersHandler < EntityHandler

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		filters = {'include' => 'versions'}.merge(filters)

		request = APIRequest.new(@origin, '/v1/platform/browsers', 'GET')
		EntityList.new(@origin, request, PlatformBrowser, filters)
	end

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/platform/browsers/' + id.to_s(), 'GET', {'params' => {'include' => 'versions'}})
		PlatformBrowser.new(@origin, req.exec)
	end

end
