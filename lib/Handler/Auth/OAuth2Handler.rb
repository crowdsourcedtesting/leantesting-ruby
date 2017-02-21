#
# Handler to manage general authentication routines
#
# leantesting.com/en/api-docs#oauth-flow
#
module LeanTesting
	class OAuth2Handler

		#
		# Constructs an OAuth2Handler instance
		#
		# Arguments:
		#	origin Client -- Originating client reference
		#
		def initialize(origin)
			@origin = origin
		end

		#
		# Function that generates link for user to follow in order to request authorization code
		#
		# Arguments:
		#	clientID    String -- client ID given at application registration
		#	redirectURI String -- URL to be redirected to after authorization
		#	scope       String -- (optional) comma-separated list of requested scopes (default: 'read')
		#	state       String -- (optional) random string for MITM attack prevention
		#
		# Exceptions:
		#	SDKInvalidArgException if provided clientID param is not a string
		#	SDKInvalidArgException if provided redirectURI param is not a string
		#	SDKInvalidArgException if provided scope param is not a string
		#	SDKInvalidArgException if provided state param is not a string
		#
		# Returns:
		#	String -- returns URL to follow for authorization code request
		#
		def generateAuthLink(clientID, redirectURI, scope = 'read', state = nil)
			if !clientID.is_a? String
				raise SDKInvalidArgException, '`clientID` must be a string'
			elsif !redirectURI.is_a? String
				raise SDKInvalidArgException, '`redirectURI` must be a string'
			elsif !scope.is_a? String
				raise SDKInvalidArgException, '`scope` must be a string'
			elsif state && !state.is_a?(String)
				raise SDKInvalidArgException, '`state` must be a string'
			end

			baseURL = 'https://app.leantesting.com/login/oauth/authorize'

			params = {
				'client_id'    => clientID,
				'redirect_uri' => redirectURI,
				'scope'        => scope
			}

			if state
				params['state'] = state
			end

			baseURL += '?' + Curl::postalize(params)
			baseURL
		end

		#
		# Generates an access token string from the provided authorization code
		#
		# Arguments:
		#	clientID     String -- client ID given at application registration
		#	clientSecret String -- client secret given at application registration
		#	grantType    String -- oauth specific grant_type value (i.e.: authorization_code)
		#	code         String -- authorization code obtained from the generated auth link
		#	redirectURI  String -- URL to be redirected to after authorization

		# Exceptions:
		#	SDKInvalidArgException if provided clientID param is not a string
		#	SDKInvalidArgException if provided clientSecret param is not a string
		#	SDKInvalidArgException if provided grantType param is not a string
		#	SDKInvalidArgException if provided code param is not a string
		#	SDKInvalidArgException if provided redirectURI param is not a string
		#
		# Returns:
		#	String -- returns obtained access token string
		#
		def exchangeAuthCode(clientID, clientSecret, grantType, code, redirectURI)
			if !clientID.is_a? String
				raise SDKInvalidArgException, '`clientID` must be a string'
			elsif !clientSecret.is_a? String
				raise SDKInvalidArgException, '`clientSecret` must be a string'
			elsif !grantType.is_a? String
				raise SDKInvalidArgException, '`grantType` must be a string'
			elsif !code.is_a? String
				raise SDKInvalidArgException, '`code` must be a string'
			elsif !redirectURI.is_a? String
				raise SDKInvalidArgException, '`redirectURI` must be a string'
			end

			params = {
				'grant_type'    => grantType,
				'client_id'     => clientID,
				'client_secret' => clientSecret,
				'redirect_uri'  => redirectURI,
				'code'          => code
			}

			req = APIRequest.new(
				@origin,
				'/login/oauth/access_token',
				'POST',
				{
					'base_uri' => 'https://app.leantesting.com',
					'params'   => params
				}
			)

			resp = req.exec
			resp
		end

	end
end
