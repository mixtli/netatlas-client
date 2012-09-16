require 'spec_helper'

shared_examples_for "a node" do 
  before do
    @user ||= Fabricate(:admin)
    NetAtlas::Resource::Base.user = 'admin@netatlas.com'
    NetAtlas::Resource::Base.pass = 'password'
  end
  context "class methods" do
    it "create", :vcr do
      node = described_class.create(Fabricate.attributes_for(factory_name))
      node.id.should be_kind_of(Integer)
    end

    it "get", :vcr => { :record => :once} do
      node = Fabricate(factory_name, :id => 1, :label => 'foobar')
      retreived_node = described_class.get(node.id)
      retreived_node.id.should eql(node.id)
      retreived_node.label.should eql('foobar')
    end


    it "find", :vcr do
      10.times do
        Fabricate(factory_name)
      end
      nodes = described_class.find
      nodes.size.should eql(10)
    end

    it "delete", :vcr do
      node = Fabricate(factory_name, :id => 1)
      result = described_class.delete(node.id)
      result.should be_true
      lambda do
        described_class.get(node.id)
      end.should raise_error(NetAtlas::Resource::Error)
    end
  end

  context "instance methods" do
    it "update", :vcr do
      Fabricate(factory_name, :id => 1)
      node = described_class.get(1)
      node.update(:label => 'New Label')
      node.label.should eql("New Label")
    end

    it "delete", :vcr do
      Fabricate(factory_name, :id => 1)
      node = described_class.get(1)
      node.delete
      lambda { described_class.get(1) }.should raise_error(NetAtlas::Resource::Error)
    end

    it "save", :vcr do
      Fabricate(factory_name, :id => 1)
      node = described_class.get(1) 
      node.label = 'New Label'
      node.save.should be_true
      node.label.should eql('New Label')
    end
  end

end
