require 'spec_helper'

describe NetAtlas::Resource::Interface do
  it_should_behave_like "a resource" do
    let(:factory_name) { :interface }
  end
  before do
    Fabricate(:admin)
  end

  context "instance methods" do
    it "update", :vcr do
      Fabricate(:interface, :id => 1)
      node = described_class.find(1)
      node.label = 'New Label'
      node.save
      node.label.should eql("New Label")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:interface, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end

  it "should get device attributes" do
    node = Fabricate(:interface, :id => 1, :label => 'foobar', :ip_address=> '127.0.0.1')
    retreived_node = described_class.find(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.ip_address.should eql(node.ip_address)
  end
end
