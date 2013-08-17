module NetAtlas
  module Resource
    class Node < Base
      collection_path '/api/nodes'
      self.schema = {:id => Integer, :label => String}
    end
  end
end
