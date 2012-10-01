class NetAtlas::Resource::Poller < NetAtlas::Resource::Base
  self.uri = '/pollers'
  self.schema = { :id => Integer, :hostname => String }
end
