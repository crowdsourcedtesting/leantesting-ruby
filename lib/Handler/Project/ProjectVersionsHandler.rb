class ProjectVersionsHandler < EntityHandler

	def initialize(origin, projectID)
		super(origin)

		@projectID = projectID
	end

	def create(fields)
		super

		supports = {
			'number' => true
		}

		if enforce(fields, supports)
			req = APIRequest.new(
				@origin,
				'/v1/projects/' + @projectID.to_s() + '/versions',
				'POST',
				{'params' => fields}
			)

			ProjectVersion.new(@origin, req.exec)
		end
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/versions', 'GET')
		EntityList.new(@origin, request, ProjectVersion, filters)
	end

end
