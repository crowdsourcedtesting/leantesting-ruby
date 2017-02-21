#
# Represents a single Entity. All remote responses are decoded and parsed into one or more Entities.
#
module LeanTesting
	class Entity
		attr_accessor :data

		@origin = nil # Reference to originating Client instance
		@data   = nil # Internal entity object data

		#
		# Constructs an Entity instance
		#
		# Arguments:
		#	origin Client -- Original client instance reference
		#	data   Hash       -- Data to be contained in the new Entity. Must be non-empty.
		#
		# Exceptions:
		#	SDKInvalidArgException if provided data param is not a hash.
		#	SDKInvalidArgException if provided data param is empty. Entities cannot be empty.
		#
		def initialize(origin, data)
			if !data.is_a? Hash
				raise SDKInvalidArgException, '`data` must be a hash'
			elsif data.length.zero?
				raise SDKInvalidArgException, '`data` must be non-empty'
			end

			@origin = origin
			@data   = data
		end

	end
end
