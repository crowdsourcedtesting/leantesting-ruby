#
# Lean Testing Ruby Client SDK
#
# https://leantesting.com/en/api-docs Adheres to official API guidelines
#

require_relative 'loader.rb'

module LeanTesting
	class Client
		attr_reader \
			:auth,
			:user,
			:projects,
			:bugs,
			:attachments,
			:platform

		attr_accessor :debugReturn

		def initialize
			@accessToken = nil

			@auth        = OAuth2Handler.new(self)
			@user        = UserHandler.new(self)
			@projects    = ProjectsHandler.new(self)
			@bugs        = BugsHandler.new(self)
			@attachments = AttachmentsHandler.new(self)
			@platform    = PlatformHandler.new(self)
		end

		#
		# Function to retrieve currently attached token.
		#
		# Returns:
		#	String  -- if a token is attached
		#	boolean -- if no token is attached
		#
		def getCurrentToken
			if !@accessToken
				return false
			end

			@accessToken
		end

		#
		# Function to attach new token to SDK Client instance. Token changes are dynamic; all objects/entities
		# originating from an instance which has had its token updated will utilize the new token automatically.
		#
		# Arguments:
		# 	accessToken String -- the string of the token to be attached
		#
		# Exceptions:
		#	SDKInvalidArgException if provided accessToken param is not a string
		#
		def attachToken(accessToken)
			if !accessToken.is_a? String
				raise SDKInvalidArgException, '`accessToken` must be a string'
			end
			@accessToken = accessToken
		end

	end
end
