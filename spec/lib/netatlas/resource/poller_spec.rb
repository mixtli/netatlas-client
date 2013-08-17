require 'spec_helper'
describe NetAtlas::Resource::Poller do 
  it_should_behave_like "a resource" do
    let(:factory_name) { :poller }
  end

  before do
    Fabricate(:admin)
  end
  context "instance methods" do
    it "update" do
      Fabricate(:poller, :id => 1)
      node = described_class.find(1)
      node.label = 'New Label'
      node.save
      node.label.should eql("New Label")
    end
    it "save", :vcr => {:record => :all} do
      r = Fabricate(:poller, :id => 1)
      node = described_class.find(1) 
      node.save.should be_true
    end
  end
end
