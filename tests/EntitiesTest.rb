require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class EntitiesTest < MiniTest::Test

	def setup
		@entityColllection = [
			[LeanTesting::Bug, {
				'comments'      => LeanTesting::BugCommentsHandler,
				'attachments'   => LeanTesting::BugAttachmentsHandler
			}],
			[LeanTesting::BugAttachment],
			[LeanTesting::BugComment],
			[LeanTesting::PlatformBrowser, {
				'versions'      => LeanTesting::PlatformBrowserVersionsHandler
			}],
			[LeanTesting::PlatformBrowserVersion],
			[LeanTesting::PlatformDevice],
			[LeanTesting::PlatformOS, {
				'versions'      => LeanTesting::PlatformOSVersionsHandler
			}],
			[LeanTesting::PlatformOSVersion],
			[LeanTesting::PlatformType, {
				'devices'       => LeanTesting::PlatformTypeDevicesHandler
			}],
			[LeanTesting::Project, {
				'sections'      => LeanTesting::ProjectSectionsHandler,
				'versions'      => LeanTesting::ProjectVersionsHandler,
				'users'         => LeanTesting::ProjectUsersHandler,

				'testCases'         => LeanTesting::ProjectTestCasesHandler,
				'testRuns'         => LeanTesting::ProjectTestRunsHandler,

				'webhooks'         => LeanTesting::ProjectWebhooksHandler,

				'bugTypeScheme'             => LeanTesting::ProjectBugTypeSchemeHandler,
				'bugStatusScheme'           => LeanTesting::ProjectBugStatusSchemeHandler,
				'bugSeverityScheme'         => LeanTesting::ProjectBugSeveritySchemeHandler,
				'bugReproducibilityScheme'  => LeanTesting::ProjectBugReproducibilitySchemeHandler,
				'bugPriorityScheme'  				=> LeanTesting::ProjectBugPrioritySchemeHandler,

				'bugs'          => LeanTesting::ProjectBugsHandler
			}],
			[LeanTesting::ProjectBugScheme],
			[LeanTesting::ProjectSection],
			[LeanTesting::ProjectUser],
			[LeanTesting::ProjectVersion],
			[LeanTesting::ProjectTestCase],
			[LeanTesting::ProjectTestRun],
			[LeanTesting::ProjectTestResult],
			[LeanTesting::ProjectWebhook],
			[LeanTesting::UserOrganization]
		]
	end



	def test_EntitiesDefined
		@entityColllection.each { |e| e[0] }
	end

	def test_EntitiesCorrectParent
		@entityColllection.each { |e| assert_kind_of LeanTesting::Entity, e[0].new(LeanTesting::Client.new, {'id'=> 1}) }
	end

	def test_EntitiesDataParsing
		data = {'id'=> 1, 'YY'=> 'strstr', 'FF'=> [1, 2, 3, 'asdasdasd'], 'GG'=> {'test1'=> true, 'test2'=> []}}
		@entityColllection.each do |e|
			assert_equal e[0].new(LeanTesting::Client.new, data).data, data
		end
	end




	def test_EntitiesInstanceNonArrData
		@entityColllection.each do |e|
			assert_raises LeanTesting::SDKInvalidArgException do
				e[0].new(LeanTesting::Client.new, '')
			end
		end
	end
	def test_EntitiesInstanceEmptyData
		@entityColllection.each do |e|
			assert_raises LeanTesting::SDKInvalidArgException do
				e[0].new(LeanTesting::Client.new, {})
			end
		end
	end





	def test_EntitiesHaveSecondaries
		@entityColllection.each do |e|
			next if e[1].nil?
			e[1].each do |sk, sv|
				assert_instance_of sv, e[0].new(LeanTesting::Client.new, {'id'=> 1}).instance_variable_get('@' + sk)
			end
		end
	end


end
