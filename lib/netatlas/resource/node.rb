module NetAtlas
  module Resource
    class Node < Base
      self.uri = '/nodes'
      self.schema = {:id => Integer, :label => String, :description => String}
    end
  end
end
