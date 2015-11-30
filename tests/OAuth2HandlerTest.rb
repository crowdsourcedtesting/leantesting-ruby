require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class OAuth2HandlerTest < MiniTest::Test

	def test_OAuth2HandlerDefined
		OAuth2Handler
	end




	def test_OAuth2HandlerGenerateNonStrClientID
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink(1, '', '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrRedirectURI
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', 1, '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrScope
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', '', 1)
		end
	end
	def test_OAuth2HandlerGenerateNonStrState
		assert_raises SDKInvalidArgException do
			OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', '', '', 1)
		end
	end




	def test_OAuth2HandlerExchangeNonStrClientID
		assert_raises SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode(1, '', '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrClientSecret
		assert_raises SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', 1, '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrGrantType
		assert_raises SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', 1, '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrCode
		assert_raises SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', '', 1, '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrRedirectURI
		assert_raises SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			OAuth2Handler.new(client).exchangeAuthCode('', '', '', '', 1)
		end
	end

end
