require 'spec_helper'

describe NetAtlas::Resource::Service do

  it_should_behave_like "a resource" do
    let(:factory_name) { :service }
  end
  before do
    Fabricate(:admin)
  end

  context "instance methods" do
    it "update", :vcr do
      Fabricate(:service, :id => 1)
      node = described_class.find(1)
      node.label = 'New Label'
      node.save
      node.label.should eql("New Label")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:service, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end

  it "should find service attributes" do
    node = Fabricate(:service, :id => 1, :label => 'foobar', :port => 80)
    retreived_node = described_class.find(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.port.should eql(node.port)
  end
end
