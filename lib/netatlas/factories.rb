module NetAtlas
  module Model
    class Node < ::Sequel::Model; unrestrict_primary_key; end
    class User < ::Sequel::Model; unrestrict_primary_key; end
    class Device < ::Sequel::Model; unrestrict_primary_key; end
    class Poller < ::Sequel::Model; unrestrict_primary_key; end
    class Plugin < ::Sequel::Model; unrestrict_primary_key; end
    class Service < ::Sequel::Model; unrestrict_primary_key; end
    class Event < ::Sequel::Model; unrestrict_primary_key; end
    class Interface < ::Sequel::Model; unrestrict_primary_key; end
    class DataSource < ::Sequel::Model; unrestrict_primary_key; end
    class DataStream < ::Sequel::Model; unrestrict_primary_key; end
    class Notification < ::Sequel::Model; unrestrict_primary_key; end
  end
end

Fabricator(:node, :from => 'NetAtlas::Model::Node')  do
  label 'foo'
  description  'bar'
  state 'unknown'
  created_at Time.now
  updated_at Time.now
end

Fabricator(:user, :from => 'NetAtlas::Model::User') do
  email { sequence(:email) { |i| "user#{i}@netatlas.com"}}
  # password is 'password'
  encrypted_password '$2a$10$MkM//rGucWRhbxDPOrHc7ebCEdReBE3dqGZCVntVTVmJAcOJ.Hd5G'
  admin true
  created_at Time.now
  updated_at Time.now
end



Fabricator(:admin, :from => :user) do
  email "admin@netatlas.com"
  admin true
end

Fabricator(:test_user, :from => :user) do
  email "test@netatlas.com"
end

Fabricator(:device, :from => :node, :class_name => 'NetAtlas::Model::Device') do
  hostname { sequence(:hostname) { |i| "host#{i}.lvh.me"}}
  type "Device"
end

Fabricator(:interface, :from => :node, :class_name => 'NetAtlas::Model::Interface') do
  ip_address { sequence(:ip_address) { |i| "192.168.0.#{i}"}}
  type "Interface"
end

Fabricator(:service, :from => :node, :class_name => 'NetAtlas::Model::Service') do
  type "Service"
end

Fabricator(:poller, :class_name => 'NetAtlas::Model::Poller') do
  hostname { sequence(:hostname) { |i| "host#{i}.lvh.me"}}
  queue_username { sequence(:queue_username) { |i| "user#{i}" }}
  queue_password { sequence(:queue_password) { |i| "pass#{i}" }}
  created_at Time.now
  updated_at Time.now
  state "unknown"
end
Fabricator(:plugin, :class_name => 'NetAtlas::Model::Plugin') do
  name 'Plugin'
  class_name 'SNMP'
  created_at Time.now
  updated_at Time.now
end

Fabricator(:data_source, :class_name => 'NetAtlas::Model::DataSource') do
  plugin_id { Fabricate(:plugin).id}
  node_id { Fabricate(:node).id}
  state "unknown"
  created_at Time.now
  updated_at Time.now
  arguments "{}"
end

Fabricator(:data_stream, :class_name => 'NetAtlas::Model::DataStream') do
  poller_id { Fabricate(:poller).id}
  data_source_id {Fabricate(:data_source).id }
  created_at Time.now
  updated_at Time.now
end

Fabricator(:event, :class_name => 'NetAtlas::Model::Event') do
  created_at Time.now
  updated_at Time.now
end

Fabricator(:notification, :from => 'NetAtlas::Model::Notification') do
  message "Test Message"
  created_at Time.now
  updated_at Time.now
end

