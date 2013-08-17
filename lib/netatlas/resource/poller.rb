class NetAtlas::Resource::Poller  < NetAtlas::Resource::Base
  collection_path '/api/pollers'
  resource_path '/api/pollers/:id'
  self.schema = {:id => Integer, :description => String}
end
