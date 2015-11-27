class PlatformBrowser < Entity
	attr_reader :versions

	def initialize(origin, data)
		super

		@versions = PlatformBrowserVersionsHandler.new(origin, data['id'])
	end

end
