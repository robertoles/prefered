class Array
  def to_h(&block)
    Hash[*self.collect { |v|
      [v, block.call(v)]
    }.flatten]
  end
end

module Prefered
  class PreferenceSettings
    class << self
      def evaluate(&block)
        settings = self.new
        settings.instance_eval &block
        settings
      end
    end
    
    def initialize
      @preferences = {}
      @groups = {}
    end
    attr_accessor :preferences, :groups
    
    def preference(name, options = {})
      @preferences[name.to_sym] = options
    end
    
    def group(name, &block)
      @groups[name.to_sym] = PreferenceSettings.evaluate(&block) 
    end
  end
  
  module PreferenceEngine
    def serialize_preferences(settings)
      preferences_data = settings.preferences.keys.to_h do |preference|
        send(:"#{preference}")
      end
      groups_data = settings.groups.keys.to_h do |group|
        send(:"#{group}").serialize_preferences(settings.groups[group])
      end
      preferences_data.merge(groups_data)
    end
    
    def deserialize_preferences(settings, raw_data)
      settings.preferences.keys.each do |preference|
        if raw_data.include?(preference)
          send(:"#{preference}=", raw_data[preference])
        end
      end
      settings.groups.keys.each do |group|
        if raw_data.include?(group)
          send(:"#{group}").deserialize_preferences(settings.groups[group], raw_data[group])
        end
      end
    end
    
    private
      def init_methods(settings)
        settings.preferences.each do |preference, options|
          self.instance_variable_set(:"@#{preference}", options[:default])
          self.instance_eval do
            send(:class).send(:attr_accessor, preference)
          end
        end
      
        settings.groups.each do |group, group_settings|
          self.instance_variable_set(:"@#{group}", PreferenceGroup.new(group, group_settings))
          self.instance_eval do
            send(:class).send(:attr_reader, group)
          end
        end
      end
  end
  
  class PreferenceGroup
    include PreferenceEngine
    
    def initialize(name, settings)
      @name = name
      @settings = settings
      init_methods(settings)
    end
  end
  
  class Preference < ActiveRecord::Base
    include PreferenceEngine
    serialize   :data, Hash
    belongs_to  :owner, :polymorphic => true
    
    after_initialize :init_data
    before_save :serialize_data
    
    def init_preferences
      settings = interpret_settings(&@preference_settings_block) # hack, see prefered.rb
      init_methods(settings)
      deserialize_data(settings)
    end
    
    private
      def init_data
        self.data = {} unless self.data
      end
      
      def interpret_settings(&block)
        PreferenceSettings.evaluate(&block)
      end
      
      def deserialize_data(settings)
        deserialize_preferences(settings, self.data)
      end
      
      def serialize_data
        settings = interpret_settings(&@preference_settings_block)
        self.data = serialize_preferences(settings)
      end
  end
end