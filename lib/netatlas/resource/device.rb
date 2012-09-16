class NetAtlas::Resource::Device < NetAtlas::Resource::Base
  self.uri = '/devices'
  self.schema = {:id => Integer, :label => String, :hostname => String, :description => String}
end
