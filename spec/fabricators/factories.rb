Fabricator(:node, :from => NetAtlas::Model::Node)  do
  label 'foo'
  description  'bar'
  created_at Time.now
  updated_at Time.now
end

Fabricator(:user, :from => NetAtlas::Model::User) do
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


Fabricator(:device, :from => :node, :class_name => 'NetAtlas::Model::Device') do
  hostname { sequence(:hostname) { |i| "host#{i}.lvh.me"}}
  type "Device"
end
