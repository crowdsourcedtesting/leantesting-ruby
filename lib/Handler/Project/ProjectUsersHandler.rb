class ProjectUsersHandler < EntityHandler

	def initialize(origin, projectID)
		super(origin)

		@projectID = projectID
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/users', 'GET')
		EntityList.new(@origin, request, ProjectUser, filters)
	end

end
