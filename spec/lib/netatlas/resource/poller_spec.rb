require 'spec_helper'
describe NetAtlas::Resource::Poller do 
  it_should_behave_like "a resource" do
    let(:factory_name) { :poller }
  end

end
