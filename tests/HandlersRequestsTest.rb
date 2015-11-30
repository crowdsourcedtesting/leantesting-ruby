require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class HandlersTest < MiniTest::Test

	def setup
		@handlerCollection = [
			[AttachmentsHandler],
			[BugAttachmentsHandler,						'requiresIDInConstructor'],
			[BugCommentsHandler,						'requiresIDInConstructor'],
			[BugsHandler],
			[PlatformBrowsersHandler],
			[PlatformBrowserVersionsHandler,			'requiresIDInConstructor'],
			[PlatformDevicesHandler],
			[PlatformHandler],
			[PlatformOSHandler],
			[PlatformOSVersionsHandler,					'requiresIDInConstructor'],
			[PlatformTypeDevicesHandler,				'requiresIDInConstructor'],
			[PlatformTypesHandler],
			[ProjectBugReproducibilitySchemeHandler,	'requiresIDInConstructor'],
			[ProjectBugSeveritySchemeHandler,			'requiresIDInConstructor'],
			[ProjectBugsHandler,						'requiresIDInConstructor'],
			[ProjectBugStatusSchemeHandler,				'requiresIDInConstructor'],
			[ProjectBugTypeSchemeHandler,				'requiresIDInConstructor'],
			[ProjectSectionsHandler,					'requiresIDInConstructor'],
			[ProjectsHandler],
			[ProjectUsersHandler,						'requiresIDInConstructor'],
			[ProjectVersionsHandler,					'requiresIDInConstructor'],
			[UserHandler],
			[UserOrganizationsHandler]
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
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
			assert_raises SDKInvalidArgException do
				inst.update(5, {})
			end
		end
	end





	# HAVE SECONDARIES
	def test_PlatformHandlerHasTypes
		assert_instance_of PlatformTypesHandler, PlatformHandler.new(LeanTesting::Client.new).types
	end
	def test_PlatformHandlerHasDevices
		assert_instance_of PlatformDevicesHandler, PlatformHandler.new(LeanTesting::Client.new).devices
	end
	def test_PlatformHandlerHasOS
		assert_instance_of PlatformOSHandler, PlatformHandler.new(LeanTesting::Client.new).os
	end
	def test_PlatformHandlerHasBrowsers
		assert_instance_of PlatformBrowsersHandler, PlatformHandler.new(LeanTesting::Client.new).browsers
	end
	def test_UserHandlerHasOrganizations
		assert_instance_of UserOrganizationsHandler, UserHandler.new(LeanTesting::Client.new).organizations
	end
	# END HAVE SECONDARIES

end
