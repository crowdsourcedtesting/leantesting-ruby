class PlatformHandler < EntityHandler
	attr_reader \
		:types,
		:devices,
		:os,
		:browsers

	@types		= nil
	@devices	= nil
	@os			= nil
	@browsers	= nil

	def initialize(origin)
		super

		@types		= PlatformTypesHandler.new(origin)
		@devices	= PlatformDevicesHandler.new(origin)
		@os			= PlatformOSHandler.new(origin)
		@browsers	= PlatformBrowsersHandler.new(origin)
	end

end
