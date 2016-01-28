require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class BaseClassesTest < MiniTest::Test

	def test_ClientDefined
		LeanTesting::Client.new
	end




	def test_ClientHasAuthObj
		assert_instance_of LeanTesting::OAuth2Handler, LeanTesting::Client.new.auth
	end
	def test_ClientHasUserObj
		assert_instance_of LeanTesting::UserHandler, LeanTesting::Client.new.user
	end
	def test_ClientHasProjectsObj
		assert_instance_of LeanTesting::ProjectsHandler, LeanTesting::Client.new.projects
	end
	def test_ClientHasBugsObj
		assert_instance_of LeanTesting::BugsHandler, LeanTesting::Client.new.bugs
	end
	def test_ClientHasAttachmentsObj
		assert_instance_of LeanTesting::AttachmentsHandler, LeanTesting::Client.new.attachments
	end
	def test_ClientHasPlatformObj
		assert_instance_of LeanTesting::PlatformHandler, LeanTesting::Client.new.platform
	end



	def test_InitialEmptyToken
		assert !LeanTesting::Client.new.getCurrentToken
	end
	def test_TokenParseStorage
		tokenName = '__token__test__'
		client = LeanTesting::Client.new
		client.attachToken(tokenName)

		assert_equal client.getCurrentToken, tokenName
	end
	def test_TokenParseNonStr
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::Client.new.attachToken(7182381)
		end
	end

end
