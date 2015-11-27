class Project < Entity
	attr_reader \
		:sections,
		:versions,
		:users,
		:bugTypeScheme,
		:bugStatusScheme,
		:bugSeverityScheme,
		:bugReproducibilityScheme,
		:bugs

	def initialize(origin, data)
		super

		@sections = ProjectSectionsHandler.new(origin, data['id'])
		@versions = ProjectVersionsHandler.new(origin, data['id'])
		@users    = ProjectUsersHandler.new(origin, data['id'])

		@bugTypeScheme            = ProjectBugTypeSchemeHandler.new(origin, data['id'])
		@bugStatusScheme          = ProjectBugStatusSchemeHandler.new(origin, data['id'])
		@bugSeverityScheme        = ProjectBugSeveritySchemeHandler.new(origin, data['id'])
		@bugReproducibilityScheme = ProjectBugReproducibilitySchemeHandler.new(origin, data['id'])

		@bugs = ProjectBugsHandler.new(origin, data['id'])
	end

end
