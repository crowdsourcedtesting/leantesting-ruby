class AttachmentsHandler < EntityHandler

	def find(id)
		super

		req = APIRequest.new(@origin, '/v1/attachments/' + id.to_s(), 'GET')
		BugAttachment.new(@origin, req.exec)
	end

	def delete(id)
		super

		req = APIRequest.new(@origin, '/v1/attachments/' + id.to_s(), 'DELETE')
		req.exec
	end

end
