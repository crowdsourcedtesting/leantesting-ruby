class UserHandler < EntityHandler
	attr_reader :organizations

	def initialize(origin)
		super

		@organizations = UserOrganizationsHandler.new(origin)
	end

	def getInformation
		return (APIRequest.new(@origin, '/v1/me', 'GET')).exec
	end

end
