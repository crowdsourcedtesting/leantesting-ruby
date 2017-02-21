# Lean Testing Ruby SDK

[![Gem Version](https://badge.fury.io/rb/leantesting.svg)](https://badge.fury.io/rb/leantesting)

**Ruby client for [Lean Testing](https://leantesting.com/) API**

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

client = LeanTesting::Client.new
client.attachToken('<token>')

# Listing projects
projects = client.projects.all()

# Fetching project bugs
bugs = client.projects.find(123).bugs.all()
```

## Methods

- Get Current **Token**
```ruby
client.getCurrentToken
```

- Attach New **Token**
```ruby
client.attachToken('<token>')
```

- Generate **Authorization URL**
```ruby
generatedURL = client.auth.generateAuthLink(
	'<client id>',
	'<redirect URL>',
	'<scope>',
	'<random string>'
)
p generatedURL
```

- Exchange authorization code For **access token**
```ruby
token = client.auth.exchangeAuthCode(
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
client.user.getInformation
```

- Get **User** Organizations
```ruby
client.user.organizations.all.toArray
```

- Retrieve An Existing **User Organization**
```ruby
client.user.organizations.find(31).data
```

----

- List All **Projects**
```ruby
client.projects.all.toArray
```

- Create A New **Project**
```ruby
newProject = client.projects.create({
	'name' => 'Project135',
	'organization_id' => 5779
})
p newProject.data
```

- Retrieve An Existing **Project**
```ruby
client.projects.find(3515).data
```


- List **Project Sections**
```ruby
client.projects.find(3515).sections.all.toArray
```

- Adding A **Project Section**
```ruby
newSection = client.projects.find(3515).sections.create({
	'name' => 'SectionName'
})
p newSection.data
```


- List **Project Versions**
```ruby
client.projects.find(3515).versions.all.toArray
```

- Adding A **Project Version**
```ruby
newVersion = client.projects.find(3515).versions.create({
	'number' => 'v0.3.1104'
})
p newVersion.data
```

- List **Project Test Cases**

```ruby
client.projects.find(3515).testCases.all.toArray
```

- List **Project Test Runs**

```ruby
client.projects.find(3515).testRuns.all.toArray
```

- Retrieve Results For **Test Run**
```ruby
client.projects.find(3515).testRuns.find(123).data
```


- List **Project Users**
```ruby
client.projects.find(3515).users.all.toArray
```

- Remove A **Project User**
```ruby
client.projects.find(3515).users.delete(123)
```

- List **Bug Type Scheme**
```ruby
client.projects.find(3515).bugTypeScheme.all.toArray
```

- List **Bug Status Scheme**
```ruby
client.projects.find(3515).bugStatusScheme.all.toArray
```

- List **Bug Severity Scheme**
```ruby
client.projects.find(3515).bugSeverityScheme.all.toArray
```

- List **Bug Reproducibility Scheme**
```ruby
client.projects.find(3515).bugReproducibilityScheme.all.toArray
```

----

- List All **Bugs** In A Project
```ruby
client.projects.find(3515).bugs.all.toArray
```

- Create A New **Bug**
```ruby
newBug = client.projects.find(3515).bugs.create({
	'title' => 'Something bad happened...',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p newBug.data
```

- Retrieve Existing **Bug**
```ruby
client.bugs.find(38483).data
```

- Update A **Bug**
```ruby
updatedBug = client.bugs.update(118622, {
	'title' => 'Updated title',
	'status_id' => 1,
	'severity_id' => 2,
	'project_version_id' => 10242
})
p updatedBug.data
```

- Delete A **Bug**
```ruby
client.bugs.delete(118622)
```

----

- List Bug **Comments**
```ruby
client.bugs.find(38483).comments.all.toArray
```

----

- List Bug **Attachments**
```ruby
client.bugs.find(38483).attachments.all.toArray
```

- Upload An **Attachment**
```ruby
filePath = '/place/Downloads/Images/1370240743_2294218.jpg'
newAttachment = client.bugs.find(38483).attachments.upload(filePath)
p newAttachment.data
```

- Retrieve An Existing **Attachment**
```ruby
client.attachments.find(21515).data
```

- Delete An **Attachment**
```ruby
client.attachments.delete(75258)
```

----

- List **Platform Types**
```ruby
client.platform.types.all.toArray
```

- Retrieve **Platform Type**
```ruby
client.platform.types.find(1).data
```


- List **Platform Devices**
```ruby
client.platform.types.find(1).devices.all.toArray
```

- Retrieve Existing **Device**
```ruby
client.platform.devices.find(11).data
```


- List **OS**
```ruby
client.platform.os.all.toArray
```

- Retrieve Existing **OS**
```ruby
client.platform.os.find(1).data
```

- List **OS Versions**
```ruby
client.platform.os.find(1).versions.all.toArray
```


- List **Browsers**
```ruby
client.platform.browsers.all.toArray
```

- Retrieve Existing **Browser**
```ruby
client.platform.browsers.find(1).data
```

- List **Browser Versions**
```ruby
client.platform.browsers.find(1).versions.all.toArray
```

----

- Using **Filters**
```ruby
client.projects.find(3515).bugs.all({'limit' => 2, 'page' => 5}).toArray
```

- **Entity List** Functions
```ruby
browsers = client.platform.browsers.all
p browsers.total
p browsers.totalPages
p browsers.count
p browsers.toArray
```

- **Entity List** Iterator
When used in for loops, entity lists will automatically cycle to first page, regardless of `page` filter.
After ending the loop, the entity list will **NOT** revert to first page or the initial instancing `page` filter setting in order not to cause useless API request calls.
```ruby
comments = client.bugs.find(38483).comments.all({'limit' => 1})
comments.each{ |page| p page }
```

- **Entity List** Manual Iteration
```ruby
comments = client.bugs.find(38483).comments.all({'limit' => 1})
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
