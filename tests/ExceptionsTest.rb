require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/Client'

class ExceptionsTest < MiniTest::Test

	def setup
		@exceptionCollection = [
			[SDKException],
			[SDKBadJSONResponseException],
			[SDKDuplicateRequestException],
			[SDKErrorResponseException],
			[SDKIncompleteRequestException],
			[SDKInvalidArgException],
			[SDKMissingArgException],
			[SDKUnexpectedResponseException],
			[SDKUnsupportedRequestException]
		]
	end


	def test_ExceptionsDefined
		@exceptionCollection.each { |e| e[0] }
	end




	def test_ExceptionsRaiseNoArgs
		@exceptionCollection.each do |e|
			ex = assert_raises e[0] do
				raise e[0]
			end
			assert_match 'SDK Error', ex.message
		end
	end
	def test_ExceptionsRaiseWithStr
		@exceptionCollection.each do |e|
			ex = assert_raises e[0] do
				raise e[0], 'XXXmsgXXX'
			end
			assert_match 'XXXmsgXXX', ex.message
		end
	end



	# RAISE WITH ARR (when supported)
	def test_DuplicateRequestRaiseWithArr
		ex = assert_raises SDKDuplicateRequestException do
			raise SDKDuplicateRequestException, ['xx', 'yy', 'zz']
		end
		assert_match 'Duplicate', ex.message
	end
	def test_IncompleteRequestRaiseWithArr
		ex = assert_raises SDKIncompleteRequestException do
			raise SDKIncompleteRequestException, ['xx', 'yy', 'zz']
		end
		assert_match 'Incomplete', ex.message
	end
	def test_UnsupportedRequestRaiseWithArr
		ex = assert_raises SDKUnsupportedRequestException do
			raise SDKUnsupportedRequestException, ['xx', 'yy', 'zz']
		end
		assert_match 'Unsupported', ex.message
	end
	# END RAISE WITH ARR

end
