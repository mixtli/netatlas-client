require 'spec_helper'

describe NetAtlas::Resource::Event do

  it_should_behave_like "a resource" do
    let(:factory_name) { :event }
  end
  before do
    Fabricate(:admin)
  end
  context "instance methods" do
    it "update", :vcr => {:record => :all} do
      Fabricate(:event, :id => 1, :state => 'open')
      node = described_class.find(1)
      node.notes = 'New Note'
      node.save
      node.notes.should eql("New Note")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:event, :id => 1, :state => 'open')
      node = described_class.find(1) 
      node.save.should be_true
    end
  end

  it "should get device attributes" do
    node = Fabricate(:event, :id => 1, :notes => 'xyz')
    retreived_node = described_class.find(node.id)
    retreived_node.id.should eql(node.id)
    retreived_node.notes.should eql(node.notes)
  end
end
