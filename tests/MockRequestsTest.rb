require 'bundler'
Bundler.require(:default, :test)

require_relative '../lib/leantesting'

class MockRequestsTest < MiniTest::Test

	def setup
		@client = LeanTesting::Client.new
	end

	private

	def rint(min = 100, max = 9999999)
		rand(min..max)
	end
	def rstr(ln = nil)
		if !ln
			ln = rint(1, 15)
		end

		c = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
		s = ''

		(0..ln).each{ |i| s += c[rand(0..c.length) - 1] }

		s
	end
	def robj(fields)
		obj = {}

		fields.each do |f|
			if f[0] == '_'
				obj[f[1..-1]] = rint
			else
				obj[f] = rstr
			end
		end

		obj
	end
	def rcol(name, fields)
		col = {}
		col[name] = []

		(0..rint(1, 7)).each{ |i| col[name].push(robj(fields)) }

		totalPages = rint(2, 15)
		count = col[name].length
		perPage = count
		total = totalPages * perPage

		col['meta'] = {
			'pagination'=> {
				'total'=> total,
				'count'=> count,
				'per_page'=> perPage,
				'current_page'=> rint(1, totalPages),
				'total_pages'=> totalPages,
				'links'=> {}
			}
		}

		col
	end

	public

	# USER
	def test_GetUserInformation
		resp = robj(['first_name', 'created_at', '_id', 'last_name', 'avatar', 'email', 'username'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		data = @client.user.getInformation

		assert_equal resp, data
	end
	def test_GetUserOrganizations
		colName = 'organizations'
		retClass = LeanTesting::UserOrganization
		resp = rcol(colName, ['_id', 'name', 'alias', 'url', 'logo'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = @client.user.organizations.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	# END USER






	# PROJECT
	def test_ListAllProjects
		colName = 'projects'
		retClass = LeanTesting::Project
		resp = rcol(colName, ['_id', 'name', '_owner_id', '_organization_id', '_is_archived', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = @client.projects.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_CreateNewProject
		retClass = LeanTesting::Project
		resp = robj(['_id', 'name', '_owner_id', '_organization_id', '_is_archived', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.projects.create({
			'name'=> '', 'organization_id'=> 0
		})

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_RetrieveExistingProject
		retClass = LeanTesting::Project
		resp = robj(['_id', 'name', '_owner_id', '_organization_id', '_is_archived', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.projects.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end


	def test_ListProjectSections
		colName = 'sections'
		retClass = LeanTesting::ProjectSection
		resp = rcol(colName, ['_id', 'name', '_project_id'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).sections.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_AddProjectSection
		retClass = LeanTesting::ProjectSection
		resp = robj(['_id', 'name', '_project_id'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = LeanTesting::Project.new(@client, {'id'=> 0}).sections.create({
			'name'=> ''
		})

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end


	def test_ListProjectVersions
		colName = 'versions'
		retClass = LeanTesting::ProjectVersion
		resp = rcol(colName, ['_id', 'number', '_project_id'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).versions.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_AddProjectVersion
		retClass = LeanTesting::ProjectVersion
		resp = robj(['_id', 'number', '_project_id'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = LeanTesting::Project.new(@client, {'id'=> 0}).versions.create({
			'number'=> ''
		})

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end


	def test_ListProjectUsers
		colName = 'users'
		retClass = LeanTesting::ProjectUser
		resp = rcol(colName, ['_id', 'username', 'first_name', 'last_name', 'avatar', 'email', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).users.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end


	def test_ListProjectBugTypeScheme
		colName = 'scheme'
		retClass = LeanTesting::ProjectBugScheme
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).bugTypeScheme.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_ListProjectBugStatusScheme
		colName = 'scheme'
		retClass = LeanTesting::ProjectBugScheme
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).bugStatusScheme.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_ListProjectBugSeverityScheme
		colName = 'scheme'
		retClass = LeanTesting::ProjectBugScheme
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).bugSeverityScheme.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_ListProjectBugReproducibilityScheme
		colName = 'scheme'
		retClass = LeanTesting::ProjectBugScheme
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).bugReproducibilityScheme.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	# END PROJECT








	# BUG
	def test_ListBugsInProject
		colName = 'bugs'
		retClass = LeanTesting::Bug
		resp = rcol(colName, ['_id', 'title', '_status_id', '_severity_id', '_project_version_id',
			'_project_section_id', '_type_id', '_reproducibility_id', '_priority_id', '_assigned_user_id', 'description',
			'expected_results'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Project.new(@client, {'id'=> 0}).bugs.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_CreateNewBug
		retClass = LeanTesting::Bug
		resp = robj(['_id', 'title', '_status_id', '_severity_id', '_project_version_id',
			'_project_section_id', '_type_id', '_reproducibility_id', '_priority_id', '_assigned_user_id', 'description',
			'expected_results'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = LeanTesting::Project.new(@client, {'id'=> 0}).bugs.create({
			'title'=> '', 'status_id'=> 0, 'severity_id'=> 0, 'project_version_id'=> 0, 'project_section_id'=> 0,
			'type_id'=> 0, 'reproducibility_id'=> 0, 'priority_id'=> 0, 'assigned_user_id'=> 0, 'description'=> '',
			'expected_results'=> ''
		})

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_RetrieveExistingBug
		retClass = LeanTesting::Bug
		resp = robj(['_id', 'title', '_status_id', '_severity_id', '_project_version_id',
			'_project_section_id', '_type_id', '_reproducibility_id', '_priority_id', '_assigned_user_id', 'description',
			'expected_results'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.bugs.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_UpdateBug
		retClass = LeanTesting::Bug
		resp = robj(['_id', 'title', '_status_id', '_severity_id', '_project_version_id',
			'_project_section_id', '_type_id', '_reproducibility_id', '_priority_id', '_assigned_user_id', 'description',
			'expected_results'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.bugs.update(0, {
			'title'=> '', 'status_id'=> 0, 'severity_id'=> 0, 'priority_id'=> 0, 'project_version_id'=> 0, 'project_section_id'=> 0,
			'type_id'=> 0, 'assigned_user_id'=> 0, 'description'=> '', 'expected_results'=> ''
		})

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_DeleteBug
		@client.debugReturn = {'data'=> nil, 'status'=> 204}

		data = @client.bugs.delete(0)

		assert data == true
	end
	# END BUG







	# BUG COMMENTS
	def test_ListBugComments
		colName = 'comments'
		retClass = LeanTesting::BugComment
		resp = rcol(colName, ['_id', 'text', '_owner_id', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Bug.new(@client, {'id'=> 0}).comments.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	# END BUG COMMENTS








	# BUG ATTACHMENTS
	def test_ListBugAttachments
		colName = 'attachments'
		retClass = LeanTesting::BugAttachment
		resp = rcol(colName, ['_id', '_owner_id', 'url', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::Bug.new(@client, {'id'=> 0}).attachments.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_CreateNewAttachment
		retClass = LeanTesting::BugAttachment
		resp = robj(['_id', '_owner_id', 'url', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		_fp = File.expand_path(File.dirname(__FILE__)) + '/res/upload_sample.jpg'
		obj = LeanTesting::Bug.new(@client, {'id'=> 0}).attachments.upload(_fp)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_RetrieveExistingAttachment
		retClass = LeanTesting::BugAttachment
		resp = robj(['_id', '_owner_id', 'url', 'created_at'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.attachments.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_DeleteAttachment
		@client.debugReturn = {'data'=> nil, 'status'=> 204}

		data = @client.attachments.delete(0)

		assert data == true
	end
	# END BUG ATTACHMENTS








	# PLATFORM
	def test_ListPlatformTypes
		colName = 'types'
		retClass = LeanTesting::PlatformType
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = @client.platform.types.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_RetrievePlatformType
		retClass = LeanTesting::PlatformType
		resp = robj(['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.platform.types.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end

	def test_ListPlatformDevices
		colName = 'devices'
		retClass = LeanTesting::PlatformDevice
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::PlatformType.new(@client, {'id'=> 0}).devices.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_RetrievePlatformDevice
		retClass = LeanTesting::PlatformDevice
		resp = robj(['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.platform.devices.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end

	def test_ListOS
		colName = 'os'
		retClass = LeanTesting::PlatformOS
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = @client.platform.os.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_RetrieveOS
		retClass = LeanTesting::PlatformOS
		resp = robj(['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.platform.os.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_ListOSVersions
		colName = 'versions'
		retClass = LeanTesting::PlatformOSVersion
		resp = rcol(colName, ['_id', 'number'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::PlatformOS.new(@client, {'id'=> 0}).versions.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end

	def test_ListBrowsers
		colName = 'browsers'
		retClass = LeanTesting::PlatformBrowser
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = @client.platform.browsers.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	def test_RetrieveBrowser
		retClass = LeanTesting::PlatformBrowser
		resp = robj(['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		obj = @client.platform.browsers.find(0)

		assert_equal resp, obj.data
		assert_instance_of retClass, obj
	end
	def test_ListBrowserVersions
		colName = 'versions'
		retClass = LeanTesting::PlatformBrowserVersion
		resp = rcol(colName, ['_id', 'name'])
		@client.debugReturn = {'data'=> JSON.generate(resp), 'status'=> 200}

		col = LeanTesting::PlatformBrowser.new(@client, {'id'=> 0}).versions.all

		assert_equal resp[colName], col.toArray
		assert_instance_of retClass, col.collection[0]
		assert_equal resp['meta']['pagination']['total'], col.total
		assert_equal resp['meta']['pagination']['total_pages'], col.totalPages
		assert_equal resp['meta']['pagination']['count'], col.count
	end
	# END PLATFORM

end
