require 'spec_helper'

describe NetAtlas::Resource::Notification do

  it_should_behave_like "a resource" do
    let(:factory_name) { :notification }
  end
  before do
    Fabricate(:admin)
  end
  context "instance methods" do
    it "update" do
      Fabricate(:notification, :id => 1)
      notification = described_class.find(1)
      notification.message = 'New Message'
      notification.save
      notification.message.should eql("New Message")
    end
    it "save", :vcr => {:record => :all} do
      Fabricate(:notification, :id => 1)
      notification = described_class.find(1) 
      notification.save.should be_true
    end
  end

  it "should get notification attributes" do
    notification = Fabricate(:notification, :id => 1, :message => 'xyz')
    retreived_notification = described_class.find(notification.id)
    retreived_notification.id.should eql(notification.id)
    retreived_notification.message.should eql(notification.message)
  end
end
