require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class BaseClassesTest < MiniTest::Test

	# Entity
	def test_EntityDefined
		LeanTesting::Entity
	end

	def test_EntityDataParsing
		data = {'id' => 1}
		entity = LeanTesting::Entity.new(LeanTesting::Client.new, data)

		assert_equal entity.data, data
	end

	def test_EntityInstanceNonArrData
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::Entity.new(LeanTesting::Client.new, '')
		end
	end
	def test_EntityInstanceEmptyData
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::Entity.new(LeanTesting::Client.new, {})
		end
	end
	# END Entity



	# EntityHandler
	def test_EntityHandlerDefined
		LeanTesting::EntityHandler
	end

	def test_EntityHandlerCreateNonArrFields
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).create('')
		end
	end
	def test_EntityHandlerCreateEmptyFields
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).create({})
		end
	end

	def test_EntityHandlerAllNonArrFilters
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).all('')
		end
	end
	def test_EntityHandlerAllInvalidFilters
		ex = assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).all({'XXXfilterXXX' => 9999})
		end
		assert_match 'XXXfilterXXX', ex.message
	end
	def test_EntityHandlerAllSupportedFilters
		LeanTesting::EntityHandler.new(LeanTesting::Client.new).all({'include' => ''})
		LeanTesting::EntityHandler.new(LeanTesting::Client.new).all({'limit' => 10})
		LeanTesting::EntityHandler.new(LeanTesting::Client.new).all({'page' => 2})
	end

	def test_EntityHandlerFindNonIntID
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).find('')
		end
	end

	def test_EntityHandlerDeleteNonIntID
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).delete('')
		end
	end

	def test_EntityHandlerUpdateNonIntID
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).update('', {'x' => 5})
		end
	end
	def test_EntityHandlerUpdateNonArrFields
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).update(5, '')
		end
	end
	def test_EntityHandlerUpdateEmptyFields
		assert_raises LeanTesting::SDKInvalidArgException do
			LeanTesting::EntityHandler.new(LeanTesting::Client.new).update(5, {})
		end
	end
	# END EntityHandler

end
