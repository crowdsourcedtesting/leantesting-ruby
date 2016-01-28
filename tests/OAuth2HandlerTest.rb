require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class OAuth2HandlerTest < MiniTest::Test

	def test_OAuth2HandlerDefined
		LeanTesting::OAuth2Handler
	end




	def test_OAuth2HandlerGenerateNonStrClientID
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink(1, '', '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrRedirectURI
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', 1, '')
		end
	end
	def test_OAuth2HandlerGenerateNonStrScope
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', '', 1)
		end
	end
	def test_OAuth2HandlerGenerateNonStrState
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::OAuth2Handler.new(LeanTesting::Client.new).generateAuthLink('', '', '', 1)
		end
	end




	def test_OAuth2HandlerExchangeNonStrClientID
		assert_raises LeanTesting::SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			LeanTesting::OAuth2Handler.new(client).exchangeAuthCode(1, '', '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrClientSecret
		assert_raises LeanTesting::SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			LeanTesting::OAuth2Handler.new(client).exchangeAuthCode('', 1, '', '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrGrantType
		assert_raises LeanTesting::SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			LeanTesting::OAuth2Handler.new(client).exchangeAuthCode('', '', 1, '', '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrCode
		assert_raises LeanTesting::SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			LeanTesting::OAuth2Handler.new(client).exchangeAuthCode('', '', '', 1, '')
		end
	end
	def test_OAuth2HandlerExchangeNonStrRedirectURI
		assert_raises LeanTesting::SDKInvalidArgException do
			client = LeanTesting::Client.new
			client.debugReturn = '{}'
			LeanTesting::OAuth2Handler.new(client).exchangeAuthCode('', '', '', '', 1)
		end
	end

end
