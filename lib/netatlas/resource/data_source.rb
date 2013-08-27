require_relative "../resource"
class NetAtlas::Resource::DataSource < NetAtlas::Resource::Base
  collection_path '/api/data_sources'
  belongs_to :node
  self.schema = {:id => Integer, :description => String}
  attr_accessor :last_result

  def get_plugin
    @real_plugin ||= eval "NetAtlas::Plugin::#{plugin_name}.new"
  end
end

