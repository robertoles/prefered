require 'rubygems'
require 'rspec'
require 'shoulda'

begin
  require 'ruby-debug'
rescue LoadError
  puts "ruby-debug not loaded"
end

ROOT = File.join(File.dirname(__FILE__), '..')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include RSpec::Prefered::ModelHelpers
end