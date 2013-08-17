require 'spec_helper'

describe NetAtlas::Resource::DataSource do

  it_should_behave_like "a resource" do
    let(:factory_name) { :data_source }
  end
  before do
    Fabricate(:admin)
  end

  it "should get data_source attributes" do
    node = Fabricate(:data_source, :id => 1, :description => 'foobar')
    retreived_node = described_class.find(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.description.should eql(node.description)
  end

  context "instance methods" do
    it "update", :vcr do
      Fabricate(:data_source, :id => 1)
      node = described_class.find(1)
      node.label = 'New Label'
      node.save
      node.label.should eql("New Label")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:data_source, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end
end
