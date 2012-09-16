require 'spec_helper'
ENV['GLI_DEBUG'] = 'true'

describe "CLI node", :integration do
  before do
    @aruba_timeout_seconds = 5
    @user = Fabricate(:admin)
  end

  context "list" do
    before do
      10.times { Fabricate(:device)}
    end
    it "should display a table" do
      netatlas "device list"
      puts all_stdout
      all_stdout.split("\n").size.should eql(23)
      all_stdout.should match(/hostname/i)
    end
  end
end