# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{prefered}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Oles"]
  s.date = %q{2010-09-13}
  s.description = %q{Allows you to add preferences to any active record model}
  s.email = %q{robertoles@me.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "lib/generators/prefered/preferences_migration_generator.rb",
     "lib/generators/prefered/templates/migration.rb",
     "lib/prefered.rb",
     "lib/prefered/preference.rb",
     "lib/tasks/gem.rake",
     "lib/tasks/rspec.rake"
  ]
  s.homepage = %q{http://github.com/robertoles/prefered}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Allows you to add preferences to any active record model}
  s.test_files = [
    "spec/lib/prefered/preference_spec.rb",
     "spec/lib/prefered_spec.rb",
     "spec/spec_helper.rb",
     "spec/support/initialize_active_record.rb",
     "spec/support/macros/model_helpers.rb",
     "spec/support/matchers/serialize_matcher.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
  end
end

