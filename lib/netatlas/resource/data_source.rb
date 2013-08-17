require_relative "../resource"
class NetAtlas::Resource::DataSource < NetAtlas::Resource::Base
  collection_path '/api/data_sources'
  self.schema = {:id => Integer, :description => String}

  def get_plugin
    @real_plugin ||= eval "NetAtlas::Plugin::#{plugin_name}.new"
  end
end

