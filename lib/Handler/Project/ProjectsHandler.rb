class ProjectsHandler < EntityHandler

	def create(fields)
		super

		supports = {
			'name'            => true,
			'organization_id' => false
		}

		if enforce(fields, supports)
			req = APIRequest.new(@origin, '/v1/projects', 'POST', {'params' => fields})
			Project.new(@origin, req.exec)
		end
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/projects', 'GET')
		EntityList.new(@origin, request, Project, filters)
	end

	def allArchived(filters = nil)
		if !filters
			filters = {}
		end

		super

		request = APIRequest.new(@origin, '/v1/projects/archived', 'GET')
		EntityList.new(@origin, request, Project, filters)
	end

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/projects/' + id.to_s(), 'GET')
		Project.new(@origin, req.exec)
	end

end
