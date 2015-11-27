class PlatformDevicesHandler < EntityHandler

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/platform/devices/' + id.to_s(), 'GET')
		PlatformDevice.new(@origin, req.exec)
	end

end
