class ProjectBugsHandler < EntityHandler

	def initialize(origin, projectID)
		super(origin)

		@projectID = projectID
	end

	def create(fields)
		super

		supports = {
			'title'              => true,
			'status_id'          => true,
			'severity_id'        => true,
			'project_version'    => true,
			'project_version_id' => true,
			'project_section_id' => false,
			'type_id'            => false,
			'reproducibility_id' => false,
			'assigned_user_id'   => false,
			'description'        => false,
			'expected_results'   => false,
			'steps'              => false,
			'platform'           => false
			# 'device_model'       => false,
			# 'device_model_id'    => false,
			# 'os'                 => false,
			# 'os_version'         => false,
			# 'os_version_id'      => false,
			# 'browser_version_id' => false
		}

		if fields.has_key? 'project_version_id'
			supports['project_version'] = false
		elsif fields.has_key? 'project_version'
			supports['project_version_id'] = false
		end

		if enforce(fields, supports)
			fields = {'include' => 'steps,platform'}.merge(fields)

			req = APIRequest.new(
				@origin,
				'/v1/projects/' + @projectID.to_s() + '/bugs',
				'POST',
				{'params' => fields}
			)

			Bug.new(@origin, req.exec)
		end
	end

	def all(filters = nil)
		if !filters
			filters = {}
		end

		super

		filters = {'include' => 'steps,platform,attachments,comments,tags'}.merge(filters)

		request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/bugs', 'GET')
		EntityList.new(@origin, request, Bug, filters)
	end

end
