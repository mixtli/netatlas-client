require 'faraday'
require 'faraday_middleware'
require 'her'
require 'command_line_reporter'
require 'json'
require 'active_support/core_ext'
require 'netatlas/client/version'
require 'netatlas/renderer/table'
require 'netatlas/middleware/basic_auth'
module NetAtlas
  API = Her::API.new
  def self.setup(options = {})
    API.setup :url => options[:url] do |conn|
      logger = options[:logger]
      conn.use Her::Middleware::AcceptJSON
      conn.use FaradayMiddleware::EncodeJson
      conn.use Her::Middleware::DefaultParseJSON
      conn.use Faraday::Response::RaiseError
      if logger
        conn.use Faraday::Response::Logger, logger
      end
      conn.use NetAtlas::BasicAuthMiddleware, {:user => options[:user], :password => options[:password]}
      conn.use Faraday::Adapter::NetHttp
    end
  end
end
require 'netatlas/resource'
Dir[File.dirname(__FILE__) + "/resource/*.rb"].each {|file| require file }
