module LeanTesting
  class ProjectWebhooksHandler < LeanTesting::EntityHandler

    def initialize(origin, projectID)
      super(origin)

      @projectID = projectID
    end

    def create(fields)
      super

      supports = {
          'url' => true,
          'bug_create' => false,
          'bug_create_severity_critical' => false,
          'bug_create_severity_major' => false,
          'bug_create_priority_critical' => false,
          'bug_create_priority_high' => false,
          'bug_edit' => false,
          'bug_assign' => false,
          'bug_assign_target' => false,
          'bug_status_change' => false,
          'bug_resolved' => false,
          'bug_move' => false,
          'bug_delete' => false,
          'comment_create' => false,
          'comment_edit' => false,
          'message_create' => false,
          'message_edit' => false,
          'attachment_create' => false,
          'run_start' => false,
          'run_finish' => false,
      }

      if enforce(fields, supports)
        req = APIRequest.new(
            @origin,
            '/v1/projects/' + @projectID.to_s() + '/integrations/webhooks',
            'POST',
            {'params' => fields}
        )

        ProjectWebhook.new(@origin, req.exec)
      end
    end

    def all(filters = nil)
      if !filters
        filters = {}
      end

      super

      request = APIRequest.new(@origin, '/v1/projects/' + @projectID.to_s() + '/integrations/webhooks', 'GET')
      EntityList.new(@origin, request, ProjectWebhook, filters)
    end

    def delete(id)
      super

      req = APIRequest.new(
          @origin,
          '/v1/projects/' + @projectID.to_s() + '/integrations/webhooks/' + id.to_s(),
          'DELETE'
      )
      req.exec
    end

    def find(id)
      super

      req = APIRequest.new(
          @origin,
          '/v1/projects/' + @projectID.to_s() + '/integrations/webhooks/' + id.to_s(),
          'GET'
      )
      ProjectWebhook.new(@origin, req.exec)
    end

  end
end