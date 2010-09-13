require 'spec_helper'

describe Prefered do
  before {rebuild_model {}}
  
  context "ActiveRecord::Base extension" do
    subject {Dummy}
  
    its(:included_modules) {should include(Prefered)}
    it {should respond_to(:has_preferences)}
    it {should respond_to(:has_settings)}
  end

  context "Instance" do
    subject {Dummy.new}
    
    it {should have_one(:preferences)}
    it {should respond_to(:settings)}
  end
end