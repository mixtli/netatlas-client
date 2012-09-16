require 'spec_helper'

describe NetAtlas::Resource::Device do

  it_should_behave_like "a node" do
    let(:factory_name) { :device }
  end
  before do
    @user ||= Fabricate(:admin)
    NetAtlas::Resource::Base.user = 'admin@netatlas.com'
    NetAtlas::Resource::Base.pass = 'password'
  end

  it "should get device attributes" do
    node = Fabricate(:device, :id => 1, :label => 'foobar', :hostname => 'host1')
    retreived_node = described_class.get(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.hostname.should eql(node.hostname)
  end
end
