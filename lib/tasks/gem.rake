begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "prefered"
    s.version = '0.1.0'
    s.summary = "Allows you to add preferences to any active record model"
    s.email = "robertoles@me.com"
    s.homepage = "http://github.com/robertoles/prefered"
    s.description = "Allows you to add preferences to any active record model"
    s.authors = ['Robert Oles']
    s.add_dependency("rails", ">= 3.0.0")
    s.files = FileList["[A-Z]*", "{lib}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end