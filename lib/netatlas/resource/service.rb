class NetAtlas::Resource::Service < NetAtlas::Resource::Base
  collection_path '/api/services'
  self.schema = {:id => Integer, :label => String}
end
