#
# An EntityList is a list of Entity objects, obtained from compiling the results of an all() call.
#
module LeanTesting
	class EntityList
		attr_reader :collection

		@origin     = nil # Reference to originating Client instance

		@identifier = nil # Class definition identifier for the collection Entities
		@collection = nil # Internal collection corresponding to current page

		@request    = nil # APIRequest definition to use for collection generation
		@filters    = nil # Filter list for generation (origins in Handler call)

		@pagination = nil # Pagination object as per response (without links)

		#
		# Constructs an Entity List instance.
		#
		# Arguments:
		#	origin     Client -- Original client instance reference
		#	request    APIRequest -- An API Request definition given by the entity collection handler. This is used for any
		#						subsequent collection regeneration, as any data updates are dependant on external requests.
		#	identifier Class      -- class definition to use for dynamic class instancing within array collection
		#	filters    Hash       -- original filters passed over from originating all() call
		#
		def initialize(origin, request, identifier, filters = nil)
			if !filters
				filters = {}
			end

			@origin     = origin
			@request    = request
			@identifier = identifier
			@filters    = filters

			generateCollectionData

		end

		#
		# Sets iterator position to first page. Ignored if already on first page.
		#
		def first
			if @pagination['current_page'] == 1
				return false
			end

			@filters['page'] = 1
			generateCollectionData
		end

		#
		# Sets iterator position to previous page. Ignored if on first page.
		#
		def previous
			if @pagination['current_page'] == 1
				return false
			end

			@filters['page'] -=1
			generateCollectionData
		end

		#
		# Sets iterator position to next page. Ignored if on last page.
		#
		def next
			if @pagination['current_page'] == @pagination['total_pages']
				return false
			end

			if @filters.has_key? 'page'
				@filters['page'] += 1
			else
				@filters['page'] = 2
			end

			generateCollectionData
		end

		#
		# Sets iterator position to last page. Ignored if already on last page.
		#
		def last
			if @pagination['current_page'] == @pagination['total_pages']
				return false
			end

			@filters['page'] = @pagination['total_pages']
			generateCollectionData
		end

		#
		# Internal loop handler for emulating enumerable functionality
		#
		def each
			first
			begin
				yield toArray
			end while self.next
		end

		#
		# Outputs total number of Entities inside multi-page collection
		#
		# Returns:
		#	Fixnum -- Number of total Entities
		#
		def total
			@pagination['total']
		end

		#
		# Outputs total number of pages the multi-page collection has, regardful of limit/per_page
		#
		# Returns:
		#	Fixnum -- Number of total pages
		#
		def totalPages
			@pagination['total_pages']
		end

		#
		# Outputs number of Entities in current collection page. Will always be same as limmit/per_page if not on last page.
		#
		# Returns:
		#	Fixnum -- Number of Entities in page
		#
		def count
			@pagination['count']
		end

		#
		# Outputs internal collection in array format (converted from Entity objects)
		#
		# Returns:
		#	Array -- array of elements converted into hashes
		#
		def toArray
			@collection.map{ |entity| entity.data }
		end

		private

		#
		# (Re)generates internal collection data based on current iteration position.
		#
		# Regeneration is done every time position changes (i.e. every time repositioning functions are used).
		#
		# Exceptions:
		#	SDKUnexpectedResponseException if no `meta` field is found
		#	SDKUnexpectedResponseException if no `pagination` field is found in `meta field`
		#	SDKUnexpectedResponseException if no collection set is found
		#	SDKUnexpectedResponseException if multiple collection sets are found
		#
		def generateCollectionData
			@collection = [] # Clear previous collection data on fresh regeneration
			@pagination = {} # Clear previous pagination data on fresh regeneration

			@request.updateOpts({'params' => @filters})
			raw = @request.exec

			if !raw.has_key? 'meta'
				raise SDKUnexpectedResponseException, 'missing `meta` field'
			elsif !raw['meta'].has_key? 'pagination'
				raise SDKUnexpectedResponseException, '`meta` missing `pagination` field'
			end

			if raw['meta']['pagination'].has_key? 'links'
				raw['meta']['pagination'].delete('links')	# Remove not needed links sub-data
			end

			@pagination = raw['meta']['pagination']			# Pass pagination data as per response meta key
			raw.delete('meta')

			if raw.length.zero?
				raise SDKUnexpectedResponseException, 'collection object missing'
			elsif raw.length > 1
				cols = raw.map{ |k,| k }.join(', ')
				raise SDKUnexpectedResponseException, 'expected one collection object, multiple received: ' + cols
			end

			classDef = @identifier # Definition to be used for dynamic Entity instancing
			raw.values[0].each{ |entity| @collection.push(classDef.new(@origin, entity)) }
		end

	end
end
