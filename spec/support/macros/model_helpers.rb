module RSpec
  module Prefered
    module ModelHelpers
      def rebuild_model(&block)
        ActiveRecord::Base.connection.create_table :dummies, :force => true do |table|
        end
        ActiveRecord::Base.connection.create_table :preferences, :force => true do |table|
          table.column :owner_type, :string
          table.column :owner_id,   :integer
          table.column :data,       :text
        end
        rebuild_class(&block)
      end

      def rebuild_class(&block)
        ActiveRecord::Base.send(:include, Prefered)
        Object.send(:remove_const, "Dummy") rescue nil
        Object.const_set("Dummy", Class.new(ActiveRecord::Base))
        Dummy.class_eval do
          include Prefered
          has_preferences &block
        end
      end
    end
  end
end