module LeanTesting
	class ProjectBugPrioritySchemeHandler < LeanTesting::EntityHandler

		def initialize(origin, projectID)
			super(origin)

			@projectID = projectID
		end

		def all(filters = nil)
			if !filters
				filters = {}
			end

			super

			request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/bug-priority-scheme', 'GET')
			EntityList.new(@origin, request, ProjectBugScheme, filters)
		end

	end
end
