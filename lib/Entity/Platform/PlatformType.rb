module LeanTesting
  class PlatformType < LeanTesting::Entity
  	attr_reader :devices

  	def initialize(origin, data)
  		super

  		@devices = PlatformTypeDevicesHandler.new(origin, data['id'])
  	end

  end
end