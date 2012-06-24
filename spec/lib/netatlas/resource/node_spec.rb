require 'spec_helper'

describe NetAtlas::Resource::Node do 
  it_should_behave_like "a node" do
    let(:factory_name) { :node }
  end
end
