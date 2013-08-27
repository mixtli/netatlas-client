class NetAtlas::Resource::Poller  < NetAtlas::Resource::Base
  collection_path '/api/pollers'
  self.schema = {:id => Integer, :description => String}
end
