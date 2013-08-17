require 'spec_helper'

shared_examples_for "a resource" do 
  context "class methods" do
    it "create", :vcr do
      node = described_class.create(Fabricate.attributes_for(factory_name))
      node.id.should be_kind_of(Integer)
    end

    it "find", :vcr do
      node = Fabricate(factory_name, :id => 1)
      retreived_node = described_class.find(node.id)
      retreived_node.id.should eql(node.id)
    end

    it "find", :vcr do
      10.times do
        Fabricate(factory_name)
      end
      nodes = described_class.all
      nodes.size.should eql(10)
    end

    it "delete", :vcr do
      node = Fabricate(factory_name, :id => 1)
      result = described_class.destroy_existing(node.id)
      result.should be_true
      lambda do
        described_class.find(node.id)
      end.should raise_error(Faraday::Error::ResourceNotFound)
    end
  end

  context "instance methods" do
    it "delete", :vcr do
      Fabricate(factory_name, :id => 1)
      node = described_class.find(1)
      node.destroy
      lambda { described_class.find(1) }.should raise_error(Faraday::Error::ResourceNotFound)
    end
  end
end
