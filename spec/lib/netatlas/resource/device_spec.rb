require 'spec_helper'

describe NetAtlas::Resource::Device do

  it_should_behave_like "a resource" do
    let(:factory_name) { :device }
  end
  before do
    Fabricate(:admin)
  end

  it "should get device attributes" do
    node = Fabricate(:device, :id => 1, :label => 'foobar', :hostname => 'host1')
    retreived_node = described_class.find(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.hostname.should eql(node.hostname)
  end

  context "instance methods" do
    it "update" do
      Fabricate(:device, :id => 1)
      node = described_class.find(1)
      node.hostname = 'blah.lvh.me'
      node.save
      node.hostname.should eql("blah.lvh.me")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:device, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end
end
