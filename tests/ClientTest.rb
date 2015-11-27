require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/Client'

class BaseClassesTest < MiniTest::Test

	def test_ClientDefined
		Client.new
	end




	def test_ClientHasAuthObj
		assert_instance_of OAuth2Handler, Client.new.auth
	end
	def test_ClientHasUserObj
		assert_instance_of UserHandler, Client.new.user
	end
	def test_ClientHasProjectsObj
		assert_instance_of ProjectsHandler, Client.new.projects
	end
	def test_ClientHasBugsObj
		assert_instance_of BugsHandler, Client.new.bugs
	end
	def test_ClientHasAttachmentsObj
		assert_instance_of AttachmentsHandler, Client.new.attachments
	end
	def test_ClientHasPlatformObj
		assert_instance_of PlatformHandler, Client.new.platform
	end



	def test_InitialEmptyToken
		assert !Client.new.getCurrentToken
	end
	def test_TokenParseStorage
		tokenName = '__token__test__'
		client = Client.new
		client.attachToken(tokenName)

		assert_equal client.getCurrentToken, tokenName
	end
	def test_TokenParseNonStr
		assert_raises SDKInvalidArgException do
			Client.new.attachToken(7182381)
		end
	end

end
