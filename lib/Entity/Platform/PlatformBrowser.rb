module LeanTesting
	class PlatformBrowser < LeanTesting::Entity
		attr_reader :versions

		def initialize(origin, data)
			super

			@versions = PlatformBrowserVersionsHandler.new(origin, data['id'])
		end

	end
end
