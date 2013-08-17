class NetAtlas::Resource::Interface < NetAtlas::Resource::Base
  collection_path '/api/interfaces'
  self.schema = {:id => Integer, :ip_address => String}
end
