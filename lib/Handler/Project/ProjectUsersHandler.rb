module LeanTesting
	class ProjectUsersHandler < LeanTesting::EntityHandler

		def initialize(origin, projectID)
			super(origin)

			@projectID = projectID
		end

		def create(fields)
			super

			supports = {
					'email' => true,
					'role_slug' => true,
			}

			if enforce(fields, supports)
				req = APIRequest.new(
						@origin,
						'/v1/projects/' + @projectID.to_s() + '/users',
						'POST',
						{'params' => fields}
				)

				ProjectUser.new(@origin, req.exec)
			end
		end

		def delete(id)
			super

			req = APIRequest.new(
					@origin,
					'/v1/projects/' + @projectID.to_s() + '/users/' + id.to_s(),
					'DELETE'
			)
			req.exec
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
end