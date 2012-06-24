require 'spec_helper'

describe NetAtlas::Resource::Device do

  it_should_behave_like "a node" do
    let(:factory_name) { :device }
  end


end
