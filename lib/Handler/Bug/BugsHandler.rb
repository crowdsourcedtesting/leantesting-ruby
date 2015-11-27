class BugsHandler < EntityHandler

	def find(id)
		super

		req = APIRequest.new(
			@origin,
			'/v1/bugs/' + id.to_s(),
			'GET',
			{
				'params' => {
					'include' => 'steps,platform,attachments,comments,tags'
				}
			}
		)
		Bug.new(@origin, req.exec)
	end

	def delete(id)
		super

		req = APIRequest.new(@origin, '/v1/bugs/' + id.to_s(), 'DELETE')
		req.exec
	end

	def update(id, fields)
		super

		supports = {
			'title'              => false,
			'status_id'          => false,
			'severity_id'        => false,
			'project_version_id' => false,
			'project_section_id' => false,
			'type_id'            => false,
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

		if enforce(fields, supports)
			fields = {'include' => 'steps,platform'}.merge(fields)

			req = APIRequest.new(@origin, '/v1/bugs/' + id.to_s(), 'PUT', {'params' => fields})
			Bug.new(@origin, req.exec)
		end
	end

end
