# Global inclusions
require 'bundler'
Bundler.require(:default)

# Relative autopath inclusion
sdkRoot = File.dirname(File.absolute_path(__FILE__))
[
	'Exception/BaseException/*.rb',
	'Exception/*.rb',

	'BaseClass/*.rb',

	'Entity/**/*.rb',

	'Handler/**/*.rb'
].each do |path|
	Dir.glob(sdkRoot + '/' + path){ |f| require(f) }
end
