module LeanTesting
	class Project < LeanTesting::Entity
		attr_reader \
			:sections,
			:versions,
			:users,
			:testRuns,
			:testCases,
			:webhooks,
			:bugTypeScheme,
			:bugStatusScheme,
			:bugSeverityScheme,
			:bugReproducibilityScheme,
			:bugPriorityScheme,
			:bugs

		def initialize(origin, data)
			super

			@sections = ProjectSectionsHandler.new(origin, data['id'])
			@versions = ProjectVersionsHandler.new(origin, data['id'])
			@users    = ProjectUsersHandler.new(origin, data['id'])

			@testRuns  = ProjectTestRunsHandler(origin, data['id'])
			@testCases = ProjectTestCasesHandler(origin, data['id'])
			@webhooks  = ProjectWebhooksHandler(origin, data['id'])

			@bugTypeScheme            = ProjectBugTypeSchemeHandler.new(origin, data['id'])
			@bugStatusScheme          = ProjectBugStatusSchemeHandler.new(origin, data['id'])
			@bugSeverityScheme        = ProjectBugSeveritySchemeHandler.new(origin, data['id'])
			@bugReproducibilityScheme = ProjectBugReproducibilitySchemeHandler.new(origin, data['id'])
			@bugPriorityScheme 				= ProjectBugPrioritySchemeHandler.new(origin, data['id'])

			@bugs = ProjectBugsHandler.new(origin, data['id'])
		end

	end
end