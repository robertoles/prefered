require 'spec_helper'

describe PreferNoutElse::Preference do
  before do 
    rebuild_model do
      preference :colour, :default => 'yellow'
      group :sizes do
        preference :width
        preference :height, :default => 20
      end
    end
  end
  
  let(:preferencer) {Dummy.create}
  let(:preference) {preferencer.preferences}
  subject {preference}
  
  it {should belong_to(:preferencer)}
  it {should serialize(:data)}
  
  describe "#colour" do
    its(:colour) {should == 'yellow'}
  end
  
  describe "#colour=" do
    before {subject.colour= 'green'}
    its(:colour) {should == 'green'}
  end
  
  describe "#group#width" do
    before {subject.sizes.width=10}
    it {subject.sizes.width.should==10}
  end
  
  describe "#group#height" do
    it {subject.sizes.height.should==20}
  end
  
  context "save and reload" do
    before do
      preference.colour='red'
      preference.sizes.width=200
      preference.sizes.height=400
      preference.save
    end
    subject {Dummy.find(preferencer.id).preferences}
    
    its(:colour) {should == 'red'}
    it {subject.sizes.width.should == 200}
    it {subject.sizes.height.should == 400}
  end
end