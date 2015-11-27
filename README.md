# Lean Testing Ruby SDK

**Ruby client for [Lean Testing API](https://leantesting.com/en/api-docs)**

You can sign up for a Lean Testing account at [https://leantesting.com](https://leantesting.com).

## Requirements

* Ruby 2.0 or greater

## Installation

Add this line to your application's Gemfile:

    gem 'leantesting'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leantesting

## Usage

```ruby
require 'leantesting'

leantesting = LeanTesting::Client.new
leantesting.attachToken('<token>')

# Listing projects
projects = leantesting.projects.all()

# Fetching project bugs
bugs = leantesting.projects.find(123).bugs.all()
```

----

- Get Current **Token**
```ruby
leantesting.getCurrentToken
```

- Attach New **Token**
```ruby
leantesting.attachToken('<token>')
```

- Generate **Authorization URL**
```ruby
generatedURL = leantesting.auth.generateAuthLink(
	'<client id>',
	'<redirect URL>',
	'<scope>',
	'<random string>'
)
p generatedURL
```

- Exchange authorization code For **access token**
```ruby
token = leantesting.auth.exchangeAuthCode(
	'<client id>',
	'<client secret>',
	'authorization_code',
	'<auth code>',
	'<redirect URL>'
)
p token
```

----

- Get **User** Information
```ruby
leantesting.user.getInformation
```

- Get **User** Organizations
```ruby
leantesting.user.organizations.all.toArray
```

----

- List All **Projects**
```ruby
leantesting.projects.all.toArray
```

- Create A New **Project**
```ruby
newProject = leantesting.projects.create({
	'name' => 'Project135',
	'organization_id' => 5779
})
p newProject.data
```

- Retrieve An Existing **Project**
```ruby
leantesting.projects.find(3515).data
```


- List **Project Sections**
```ruby
leantesting.projects.find(3515).sections.all.toArray
```

- Adding A **Project Section**
```ruby
newSection = leantesting.projects.find(3515).sections.create({
	'name' => 'SectionName'
})
p newSection.data
```


- List **Project Versions**
```ruby
leantesting.projects.find(3515).versions.all.toArray
```

- Adding A **Project Version**
```ruby
newVersion = leantesting.projects.find(3515).versions.create({
	'number' => 'v0.3.1104'
})
p newVersion.data
```


- List **Project Users**
```ruby
leantesting.projects.find(3515).users.all.toArray
```


- List **Bug Type Scheme**
```ruby
leantesting.projects.find(3515).bugTypeScheme.all.toArray
```

- List **Bug Status Scheme**
```ruby
leantesting.projects.find(3515).bugStatusScheme.all.toArray
```

- List **Bug Severity Scheme**
```ruby
leantesting.projects.find(3515).bugSeverityScheme.all.toArray
```

- List **Bug Reproducibility Scheme**
```ruby
leantesting.projects.find(3515).bugReproducibilityScheme.all.toArray
```

----

- List All **Bugs** In A Project
```ruby
leantesting.projects.find(3515).bugs.all.toArray
```

- Create A New **Bug**
```ruby
newBug = leantesting.projects.find(3515).bugs.create({
	'title' => 'Something bad happened...',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p newBug.data
```

- Retrieve Existing **Bug**
```ruby
leantesting.bugs.find(38483).data
```

- Update A **Bug**
```ruby
updatedBug = leantesting.bugs.update(118622, {
	'title' => 'Updated title',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p updatedBug.data
```

- Delete A **Bug**
```ruby
leantesting.bugs.delete(118622)
```

----

- List Bug **Comments**
```ruby
leantesting.bugs.find(38483).comments.all.toArray
```

----

- List Bug **Attachments**
```ruby
leantesting.bugs.find(38483).attachments.all.toArray
```

- Upload An **Attachment**
```ruby
filePath = '/place/Downloads/Images/1370240743_2294218.jpg'
newAttachment = leantesting.bugs.find(38483).attachments.upload(filePath)
p newAttachment.data
```

- Retrieve An Existing **Attachment**
```ruby
leantesting.attachments.find(21515).data
```

- Delete An **Attachment**
```ruby
leantesting.attachments.delete(75258)
```

----

- List **Platform Types**
```ruby
leantesting.platform.types.all.toArray
```

- Retrieve **Platform Type**
```ruby
leantesting.platform.types.find(1).data
```


- List **Platform Devices**
```ruby
leantesting.platform.types.find(1).devices.all.toArray
```

- Retrieve Existing **Device**
```ruby
leantesting.platform.devices.find(11).data
```


- List **OS**
```ruby
leantesting.platform.os.all.toArray
```

- Retrieve Existing **OS**
```ruby
leantesting.platform.os.find(1).data
```

- List **OS Versions**
```ruby
leantesting.platform.os.find(1).versions.all.toArray
```


- List **Browsers**
```ruby
leantesting.platform.browsers.all.toArray
```

- Retrieve Existing **Browser**
```ruby
leantesting.platform.browsers.find(1).data
```

- List **Browser Versions**
```ruby
leantesting.platform.browsers.find(1).versions.all.toArray
```

----

- Using **Filters**
```ruby
leantesting.projects.find(3515).bugs.all({'limit' => 2, 'page' => 5}).toArray
```

- **Entity List** Functions
```ruby
browsers = leantesting.platform.browsers.all
p browsers.total
p browsers.totalPages
p browsers.count
p browsers.toArray
```

- **Entity List** Iterator
When used in for loops, entity lists will automatically cycle to first page, regardless of `page` filter.
After ending the loop, the entity list will **NOT** revert to first page or the initial instancing `page` filter setting in order not to cause useless API request calls.
```ruby
comments = leantesting.bugs.find(38483).comments.all({'limit' => 1})
comments.each{ |page| p page }
```

- **Entity List** Manual Iteration
```ruby
comments = leantesting.bugs.find(38483).comments.all({'limit' => 1})
p comments.toArray

# Will return false if unable to move forwards
comments.next;      p comments.toArray

# Will return false if already on last page
comments.last;      p comments.toArray

# Will return false if unable to move backwards
comments.previous;  p comments.toArray

# Will return false if already on first page
comments.first;     p comments.toArray
```

## Security

Need to report a security vulnerability? Send us an email to support@crowdsourcedtesting.com or go directly to our security bug bounty site [https://hackerone.com/leantesting](https://hackerone.com/leantesting).

## Development

Install dependencies:

```bash
bundle install
```

## Tests

Install dependencies as mentioned above, then you can run the test suite:

```bash
rake test
```