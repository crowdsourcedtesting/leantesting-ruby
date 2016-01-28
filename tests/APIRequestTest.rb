require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class APIRequestTest < MiniTest::Test

	def test_APIRequestDefined
		LeanTesting::APIRequest
	end




	def test_APIRequestInstanceNonStrEndpoint
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::APIRequest.new(LeanTesting::Client.new, 12751, 'GET')
		end
	end
	def test_APIRequestInstanceNonStrMethod
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 1233)
		end
	end
	def test_APIRequestInstanceSupportedMethod
		LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'GET')
		LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'POST')
		LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'PUT')
		LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'DELETE')
	end
	def test_APIRequestInstanceNonSupportedMethod
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'XXX')
		end
	end
	def test_APIRequestInstanceNonArrOpts
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::APIRequest.new(LeanTesting::Client.new, '/', 'GET', 12123)
		end
	end
	def test_APIRequestBadJSONResponse
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{xxxxxxxxx', 'status'=> 200})

		ex = assert_raises LeanTesting::SDKBadJSONResponseException do
			req.exec
		end
		assert_match '{xxxxxxxxx', ex.message
	end






	def test_APIRequestExpectedStatus
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> '{"X": "X"}', 'status'=> 200})
		req.exec

		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'DELETE')
		req.expects(:call).returns({'data'=> '1', 'status'=> 204})
		req.exec
	end






	def test_APIRequestUnexpectedStatusDELETE
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'DELETE')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 200})

		ex = assert_raises LeanTesting::SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end





	def test_APIRequestUnexpectedStatusGET
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises LeanTesting::SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end
	def test_APIRequestUnexpectedStatusPOST
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises LeanTesting::SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end
	def test_APIRequestUnexpectedStatusPUT
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> 'XXXyyy', 'status'=> 204})

		ex = assert_raises LeanTesting::SDKErrorResponseException do
			req.exec
		end
		assert_match 'XXXyyy', ex.message
	end




	def test_APIRequestEmptyRespGET
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises LeanTesting::SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end
	def test_APIRequestEmptyRespPOST
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'POST')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises LeanTesting::SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end
	def test_APIRequestEmptyRespPUT
		req = LeanTesting::APIRequest.new(LeanTesting::Client.new, '/any/method', 'PUT')
		req.expects(:call).returns({'data'=> '{}', 'status'=> 200})

		ex = assert_raises LeanTesting::SDKUnexpectedResponseException do
			req.exec
		end
		assert_match 'Empty', ex.message
	end

end
