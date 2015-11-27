class PlatformOS < Entity
	attr_reader :versions

	def initialize(origin, data)
		super

		@versions = PlatformOSVersionsHandler.new(origin, data['id'])
	end

end
