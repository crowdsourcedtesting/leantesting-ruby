module LeanTesting
  class ProjectTestRunsHandler < LeanTesting::EntityHandler

    def initialize(origin, projectID)
      super(origin)

      @projectID = projectID
    end

    def create(fields)
      super

      supports = {
          'name' => true,
          'case_id' => true,
          'version_id' => true,
          'creator_id' => true,
          'platform' => true,
      }

      if enforce(fields, supports)
        req = APIRequest.new(
            @origin,
            '/v1/projects/' + @projectID.to_s() + '/test-runs',
            'POST',
            {'params' => fields}
        )

        ProjectTestRun.new(@origin, req.exec)
      end
    end

    def all(filters = nil)
      if !filters
        filters = {}
      end

      super

      request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/test-runs', 'GET')
      EntityList.new(@origin, request, ProjectTestRun, filters)
    end

    def find(id)
      super

      req = APIRequest.new(
          @origin,
          '/v1/projects/' + @projectID.to_s() + '/test-runs/' + id.to_s(),
          'GET'
      )
      ProjectTestRun.new(@origin, req.exec)
    end

  end
end