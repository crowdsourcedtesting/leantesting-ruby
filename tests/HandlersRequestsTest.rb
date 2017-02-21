require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class HandlersTest < MiniTest::Test

	def setup
		@handlerCollection = [
			[LeanTesting::AttachmentsHandler],
			[LeanTesting::BugAttachmentsHandler,					'requiresIDInConstructor'],
			[LeanTesting::BugCommentsHandler,						'requiresIDInConstructor'],
			[LeanTesting::BugsHandler],
			[LeanTesting::PlatformBrowsersHandler],
			[LeanTesting::PlatformBrowserVersionsHandler,			'requiresIDInConstructor'],
			[LeanTesting::PlatformDevicesHandler],
			[LeanTesting::PlatformHandler],
			[LeanTesting::PlatformOSHandler],
			[LeanTesting::PlatformOSVersionsHandler,				'requiresIDInConstructor'],
			[LeanTesting::PlatformTypeDevicesHandler,				'requiresIDInConstructor'],
			[LeanTesting::PlatformTypesHandler],
			[LeanTesting::ProjectBugReproducibilitySchemeHandler,	'requiresIDInConstructor'],
			[LeanTesting::ProjectBugPrioritySchemeHandler,			'requiresIDInConstructor'],
			[LeanTesting::ProjectBugSeveritySchemeHandler,			'requiresIDInConstructor'],
			[LeanTesting::ProjectBugsHandler,						'requiresIDInConstructor'],
			[LeanTesting::ProjectBugStatusSchemeHandler,			'requiresIDInConstructor'],
			[LeanTesting::ProjectBugTypeSchemeHandler,				'requiresIDInConstructor'],
			[LeanTesting::ProjectSectionsHandler,					'requiresIDInConstructor'],
			[LeanTesting::ProjectsHandler],
			[LeanTesting::ProjectUsersHandler,						'requiresIDInConstructor'],
			[LeanTesting::ProjectVersionsHandler,					'requiresIDInConstructor'],
			[LeanTesting::ProjectTestCasesHandler,					'requiresIDInConstructor'],
			[LeanTesting::ProjectTestRunsHandler,					'requiresIDInConstructor'],
			[LeanTesting::ProjectWebhooksHandler,					'requiresIDInConstructor'],
			[LeanTesting::UserHandler],
			[LeanTesting::UserOrganizationsHandler]
		]
	end




	def test_HandlersDefined
		@handlerCollection.each { |e| e[0] }
	end




	def test_HandlersCreateNonArrFields
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.create('')
			end
		end
	end
	def test_HandlersCreateEmptyFields
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.create({})
			end
		end
	end





	def test_HandlersAllNonArrFilters
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.all('')
			end
		end
	end
	def test_HandlersAllInvalidFilters
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.all({'XXXfilterXXX'=> 9999})
			end
		end
	end
	def test_HandlersAllSupportedFilters
		client = LeanTesting::Client.new
		client.debugReturn = {
			'data'=> '{"x": [], "meta": {"pagination": {}}}',
			'status'=> 200
		}

		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(client, 999)
			else
				inst = e[0].new(client)
			end

			inst.all({'include'=> ''})
			inst.all({'limit'=> 10})
			inst.all({'page'=> 2})
		end
	end





	def test_HandlersFindNonIntID
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.find('')
			end
		end
	end




	def test_HandlersDeleteNonIntID
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.delete('')
			end
		end
	end





	def test_HandlersUpdateNonIntID
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.update('', {'x'=> 5})
			end
		end
	end
	def test_HandlersUpdateNonArrFields
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.update(5, '')
			end
		end
	end
	def test_HandlersUpdateEmptyFields
		@handlerCollection.each do |e|
			if !e[1].nil? && e[1] == 'requiresIDInConstructor'
				inst = e[0].new(LeanTesting::Client.new, 999)
			else
				inst = e[0].new(LeanTesting::Client.new)
			end
			assert_raises LeanTesting::SDKInvalidArgException do
				inst.update(5, {})
			end
		end
	end





	# HAVE SECONDARIES
	def test_PlatformHandlerHasTypes
		assert_instance_of LeanTesting::PlatformTypesHandler, LeanTesting::PlatformHandler.new(LeanTesting::Client.new).types
	end
	def test_PlatformHandlerHasDevices
		assert_instance_of LeanTesting::PlatformDevicesHandler, LeanTesting::PlatformHandler.new(LeanTesting::Client.new).devices
	end
	def test_PlatformHandlerHasOS
		assert_instance_of LeanTesting::PlatformOSHandler, LeanTesting::PlatformHandler.new(LeanTesting::Client.new).os
	end
	def test_PlatformHandlerHasBrowsers
		assert_instance_of LeanTesting::PlatformBrowsersHandler, LeanTesting::PlatformHandler.new(LeanTesting::Client.new).browsers
	end
	def test_UserHandlerHasOrganizations
		assert_instance_of LeanTesting::UserOrganizationsHandler, LeanTesting::UserHandler.new(LeanTesting::Client.new).organizations
	end
	# END HAVE SECONDARIES

end
