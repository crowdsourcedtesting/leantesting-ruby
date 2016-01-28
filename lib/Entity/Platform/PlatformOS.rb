module LeanTesting
  class PlatformOS < LeanTesting::Entity
  	attr_reader :versions

  	def initialize(origin, data)
  		super

  		@versions = PlatformOSVersionsHandler.new(origin, data['id'])
  	end

  end
end