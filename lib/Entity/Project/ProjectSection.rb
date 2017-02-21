module LeanTesting
	class ProjectSection < LeanTesting::Entity
		attr_reader \
			:tests

		def initialize(origin, data)
			super

			@tests = ProjectTestCasesHandler.new(origin, data['id'])
		end

	end
end
