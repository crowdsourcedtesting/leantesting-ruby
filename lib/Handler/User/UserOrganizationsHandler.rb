class UserOrganizationsHandler < EntityHandler

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/me/organizations', 'GET')
		EntityList.new(@origin, request, UserOrganization, filters)
	end

end
