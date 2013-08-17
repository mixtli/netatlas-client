class NetAtlas::Resource::Device 
  include Her::Model
  uses_api(NetAtlas::API)
  collection_path '/api/devices'
  resource_path '/api/devices/:id'
  include_root_in_json true
  parse_root_in_json true
end

