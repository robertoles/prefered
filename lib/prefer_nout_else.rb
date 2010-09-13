require 'prefer_nout_else/preference'

module PreferNoutElse
  class << self
    def included base
      base.extend ClassMethods
    end
  end
  
  module ClassMethods
    def has_preferences(&block)
      has_one :preferences, :class_name => "PreferNoutElse::Preference", :as => :owner, :autosave => true, :dependent => :destroy
      alias_method :settings, :preferences
      after_initialize do
        build_preferences(:owner => self) unless preferences
        # would prefer to pass block straight to preference model through delegation, however rails assoication_proxy later
        # breaks instance_eval for the block, and the block binding becomes broken, so we have to 'pass' the block through
        # this instance variable
        preferences.instance_variable_set(:@preference_settings_block, block)
        preferences.init_preferences
      end
    end
    alias_method :has_settings, :has_preferences
  end
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, PreferNoutElse)
end