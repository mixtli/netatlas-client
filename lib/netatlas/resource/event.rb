module NetAtlas
  class Resource::Event < Resource::Base
    collection_path '/api/events'
    self.schema = {:id => Integer, :description => String}
  end
end

