require 'spec_helper'

describe NetAtlas::Resource::Node do 
  it_should_behave_like "a resource" do
    let(:factory_name) { :node }
  end
  before do
    Fabricate(:admin)
  end
  context "instance methods" do
    it "update", :vcr do
      Fabricate(:node, :id => 1)
      node = described_class.find(1)
      node.label = 'New Label'
      node.save
      node.label.should eql("New Label")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:node, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end
end
