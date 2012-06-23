require 'spec_helper'

describe NetAtlas::Resource::Node do 
  it "create", :vcr do
    node = NetAtlas::Resource::Node.create(:description => 'foo', :label => 'bar')
    node.id.should be_kind_of(Integer)
  end

  it "get", :vcr => { :record => :once} do
    node = Fabricate(:node, :id => 1, :label => 'foobar')
    retreived_node = NetAtlas::Resource::Node.get(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.label.should eql('foobar')
  end

  it "find", :vcr do
    10.times do
      Fabricate(:node)
    end
    nodes = NetAtlas::Resource::Node.find
    nodes.size.should eql(10)
  end

  it "delete", :vcr do
    node = Fabricate(:node, :id => 1)
    result = NetAtlas::Resource::Node.delete(node.id)
    result.should be_true
    lambda do
      NetAtlas::Resource::Node.get(node.id)
    end.should raise_error(NetAtlas::Resource::Error)
  end
end
