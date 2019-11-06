#
# An EntityHandler is the equivalent of a method centralizer for a corresponding endpoint (such as /v1/entities).
#
# Functional naming conventions and equivalents:
#	create(fields)      <=>  `Create a new Entity`
#	all(fields)         <=>  `List all Entities`
#	find(id)            <=>  `Retrieve an existing Entity`
#	delete(id)          <=>  `Delete an Entity`
#	update(id, fields)  <=>  `Update an Entity`
#
module LeanTesting
	class EntityHandler

		#
		# Constructs an EntityHandler instance
		#
		# Keyword arguments:
		#	origin Client -- Originating client reference
		#
		def initialize(origin)
			@origin = origin # Reference to originating Client instance
		end

		#
		# Function definition for creating a new entity. Base function checks for invalid parameters.
		#
		# Keyword arguments:
		#	fields Hash -- Non-empty hash consisting of entity data to send for adding
		#
		# Exceptions:
		#	SDKInvalidArgException if provided fields param is not a hash.
		#	SDKInvalidArgException if provided fields param is empty.
		#
		def create(fields)
			if !fields.is_a? Hash
				raise SDKInvalidArgException, '`fields` must be a hash'
			elsif fields.length.zero?
				raise SDKInvalidArgException, '`fields` must be non-empty'
			end
		end

		#
		# Function definition for listing all entities. Base function checks for invalid parameters.
		#
		# Keyword arguments:
		#	filters Hash -- (optional) Filters to apply to restrict listing. Currently supported: limit, page
		#
		# Exceptions:
		#	SDKInvalidArgException if provided filters param is not a hash.
		#	SDKInvalidArgException if invalid filter value found in filters hash.
		#
		def all(filters = nil)
			if !filters
				filters = {}
			end

			if !filters.is_a? Hash
				raise SDKInvalidArgException, '`filters` must be a hash'
			else
				filters.each do |k,|
					if !['include', 'limit', 'page'].include? k
						raise SDKInvalidArgException, 'unsupported ' + k + ' for `filters`'
					end
				end
			end

		end

		#
		# Function definition for retrieving an existing entity. Base function checks for invalid parameters.
		#
		# Keyword arguments:
		#	id Fixnum -- ID field to look for in the entity collection
		#
		# Exceptions:
		#	SDKInvalidArgException if provided id param is not an integer.
		#
		def find(id)
			if !id.is_a? Integer
				raise SDKInvalidArgException, '`id` must be of type Integer'
			end
		end

		#
		# Function definition for deleting an existing entity. Base function checks for invalid parameters.
		#
		# Keyword arguments:
		#	id Fixnum -- ID field of entity to delete in the entity collection
		#
		# Exceptions:
		#	SDKInvalidArgException if provided id param is not an integer.
		#
		def delete(id)
			if !id.is_a? Fixnum
				raise SDKInvalidArgException, '`id` must be of type Fixnum'
			end
		end

		#
		# Function definition for updating an existing entity. Base function checks for invalid parameters.
		#
		# Keyword arguments:
		#	id     Fixnum -- ID field of entity to update in the entity collection
		#	fields Hash   -- Non-empty dictionary consisting of entity data to send for update
		#
		# Exceptions:
		#	SDKInvalidArgException if provided id param is not an integer.
		#	SDKInvalidArgException if provided fields param is not a hash.
		#	SDKInvalidArgException if provided fields param is empty.
		#
		def update(id, fields)
			if !id.is_a? Fixnum
				raise SDKInvalidArgException, '`id` must be of type Fixnum'
			elsif !fields.is_a? Hash
				raise SDKInvalidArgException, '`fields` must be a hash'
			elsif fields.length.zero?
				raise SDKInvalidArgException, '`fields` must be non-empty'
			end
		end

		private

		#
		# Helper function that enforces a structure based on a supported table:
		#	- Forces use of REQUIRED fields
		#	- Detects duplicate fields
		#	- Detects unsupported fields
		#
		# Keyword arguments:
		#	obj      Hash -- Hash to be enforced
		#	supports Hash -- Support table consisting of REQUIRED and OPTIONAL keys to be used in enforcing
		#
		# Exceptions:
		#	SDKUnsupportedRequestException if unsupported fields are found
		#	SDKIncompleteRequestException  if any required field is missing
		#	SDKDuplicateRequestException   if any duplicate field is found
		#
		def enforce(obj, supports)
			sall = []				# All supported keys
			sreq = []				# Mandatory supported keys

			socc = supports.clone	# Key use occurances

			unsup = []				# Unsupported key list
			dupl  = []				# Duplicate key list
			mreq  = []				# Missing required keys

			supports.each do |sk, sv|
				if sv == true
					sreq.push(sk)
				end

				sall.push(sk)
				socc[sk] = 0
			end

			obj.each do |k,|
				if sall.include? k
					socc[k] += 1
				else
					unsup.push(k)
				end
			end

			socc.each do |ok, ov|
				if ov > 1
					dupl.push(ok)
				elsif ov == 0 && sreq.include?(ok)
					mreq.push(ok)
				end
			end

			if unsup.length.nonzero?
				raise SDKUnsupportedRequestException, unsup
			elsif mreq.length.nonzero?
				raise SDKIncompleteRequestException, mreq
			elsif dupl.length.nonzero?
				raise SDKDuplicateRequestException, dupl
			end

			true
		end

	end
end
