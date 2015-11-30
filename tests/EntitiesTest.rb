require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class EntitiesTest < MiniTest::Test

	def setup
		@entityColllection = [
			[Bug, {
				'comments'      => BugCommentsHandler,
				'attachments'   => BugAttachmentsHandler
			}],
			[BugAttachment],
			[BugComment],
			[PlatformBrowser, {
				'versions'      => PlatformBrowserVersionsHandler
			}],
			[PlatformBrowserVersion],
			[PlatformDevice],
			[PlatformOS, {
				'versions'      => PlatformOSVersionsHandler
			}],
			[PlatformOSVersion],
			[PlatformType, {
				'devices'       => PlatformTypeDevicesHandler
			}],
			[Project, {
				'sections'      => ProjectSectionsHandler,
				'versions'      => ProjectVersionsHandler,
				'users'         => ProjectUsersHandler,

				'bugTypeScheme'             => ProjectBugTypeSchemeHandler,
				'bugStatusScheme'           => ProjectBugStatusSchemeHandler,
				'bugSeverityScheme'         => ProjectBugSeveritySchemeHandler,
				'bugReproducibilityScheme'  => ProjectBugReproducibilitySchemeHandler,

				'bugs'          => ProjectBugsHandler
			}],
			[ProjectBugScheme],
			[ProjectSection],
			[ProjectUser],
			[ProjectVersion],
			[UserOrganization]
		]
	end



	def test_EntitiesDefined
		@entityColllection.each { |e| e[0] }
	end

	def test_EntitiesCorrectParent
		@entityColllection.each { |e| assert_kind_of Entity, e[0].new(LeanTesting::Client.new, {'id'=> 1}) }
	end

	def test_EntitiesDataParsing
		data = {'id'=> 1, 'YY'=> 'strstr', 'FF'=> [1, 2, 3, 'asdasdasd'], 'GG'=> {'test1'=> true, 'test2'=> []}}
		@entityColllection.each do |e|
			assert_equal e[0].new(LeanTesting::Client.new, data).data, data
		end
	end




	def test_EntitiesInstanceNonArrData
		@entityColllection.each do |e|
			assert_raises SDKInvalidArgException do
				e[0].new(LeanTesting::Client.new, '')
			end
		end
	end
	def test_EntitiesInstanceEmptyData
		@entityColllection.each do |e|
			assert_raises SDKInvalidArgException do
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
