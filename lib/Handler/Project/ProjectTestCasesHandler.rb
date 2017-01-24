module LeanTesting
  class ProjectTestCasesHandler < LeanTesting::EntityHandler

    def initialize(origin, projectID)
      super(origin)

      @projectID = projectID
    end

    def all(filters = nil)
      if !filters
        filters = {}
      end

      super

      request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/test-cases', 'GET')
      EntityList.new(@origin, request, ProjectTestCase, filters)
    end

    def find(id)
      super

      req = APIRequest.new(
          @origin,
          '/v1/projects/' + @projectID.to_s() + '/test-cases/' + id.to_s(),
          'GET'
      )
      ProjectTestCase.new(@origin, req.exec)
    end

  end
end