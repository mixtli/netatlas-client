module NetAtlas
  class Resource::Notification < Resource::Base
      collection_path '/api/notifications'
      self.schema = {:id => Integer, :description => String}
  end
end

