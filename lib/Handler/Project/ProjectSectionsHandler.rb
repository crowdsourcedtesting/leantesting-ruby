class ProjectSectionsHandler < EntityHandler

	def initialize(origin, projectID)
		super(origin)

		@projectID = projectID
	end

	def create(fields)
		super

		supports = {
			'name' => true
		}

		if enforce(fields, supports)
			req = APIRequest.new(
				@origin,
				'/v1/projects/' + @projectID.to_s() + '/sections',
				'POST',
				{'params' => fields}
			)

			ProjectSection.new(@origin, req.exec)
		end
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/sections', 'GET')
		EntityList.new(@origin, request, ProjectSection, filters)
	end

end
