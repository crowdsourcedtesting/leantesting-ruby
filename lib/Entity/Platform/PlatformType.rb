class PlatformType < Entity
	attr_reader :devices

	def initialize(origin, data)
		super

		@devices = PlatformTypeDevicesHandler.new(origin, data['id'])
	end

end
