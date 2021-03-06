module LeanTesting
	class ProjectBugStatusSchemeHandler < LeanTesting::EntityHandler

		def initialize(origin, projectID)
			super(origin)

			@projectID = projectID
		end

		def all(filters = nil)
			if !filters
				filters = {}
			end

			super

			request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/bug-status-scheme', 'GET')
			EntityList.new(@origin, request, ProjectBugScheme, filters)
		end

	end
end
