module LeanTesting
	class UserOrganizationsHandler < LeanTesting::EntityHandler

		def all(filters = nil)
			if !filters
				filters = {}
			end

			super

			request = APIRequest.new(@origin, '/v1/me/organizations', 'GET')
			EntityList.new(@origin, request, UserOrganization, filters)
		end

		def find(id)
			super

			req = APIRequest.new(@origin, '/v1/me/organizations/' + id.to_s(), 'GET')
			UserOrganization.new(@origin, req.exec)
		end

  end
end
