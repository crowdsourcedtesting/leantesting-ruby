require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/Client'

class EntityListTest < MiniTest::Test

	def test_EntityListDefined
		EntityList
	end



	def test_EntityListBadRespMissingMeta
		req = APIRequest.new(Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"x": []}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			EntityList.new(Client.new, req, 'X')
		end
		assert_match 'meta', ex.message
	end
	def test_EntityListBadRespMissingMetaPagination
		req = APIRequest.new(Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"x": [], "meta": {}}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			EntityList.new(Client.new, req, 'X')
		end
		assert_match 'pagination', ex.message
	end
	def test_EntityListBadRespMissingCollection
		req = APIRequest.new(Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"meta": {"pagination": {}}}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			EntityList.new(Client.new, req, 'X')
		end
		assert_match 'collection', ex.message
	end
	def test_EntityListBadRespMultipleCollections
		req = APIRequest.new(Client.new, '/any/method', 'GET')
		req.expects(:call).returns({'data'=> '{"xxy": [], "yyx": [], "meta": {"pagination": {}}}', 'status'=> 200})

		ex = assert_raises SDKUnexpectedResponseException do
			EntityList.new(Client.new, req, 'X')
		end
		assert_match 'multiple', ex.message
	end

end
