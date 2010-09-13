require 'rails'
require 'active_record'
require 'active_support'
require 'sqlite3'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/../database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])