require 'faraday/middleware'
module NetAtlas
  module Resource
    class Base 
      class_attribute :base_url
      class_attribute :uri
      class_attribute :user
      class_attribute :pass
      
      attr_accessor :attributes

      self.base_url = ::CONFIG['netatlas_url']
      self.user = ::CONFIG['netatlas_user']
      self.pass = ::CONFIG['netatlas_pass']
      class << self
        def find(params = {})
          response = conn.get do |req|
            req.url uri
            req.headers['Content-Type'] = 'application/json'
            req.headers['Accept'] = "application/json"
          end
          if response.status == 200
            response.body.map { |attrs| new(attrs)}
          else
            raise Error.new("Failed to find resource", response)
          end
        end

        def get(id)
          response = conn.get do |req|
            req.url uri + "/#{id}"
            req.headers['Content-Type'] = 'application/json'
            req.headers['Accept'] = "application/json"
          end
          if response.status == 200
            new(response.body)
          else
            raise Error.new("Failed to get #{id}", response)
          end
        end

        def create(params = {})
          response = conn.post do |req|
            req.url uri
            req.headers['Content-Type'] = 'application/json'
            req.headers['Accept'] = "application/json"
            req.body = params.to_json
          end
          if response.status == 201
            new(response.body)
          else
            raise Error.new("Failed to create resource", response)
          end
        end

        def update(id, params={})
          response = conn.put do |req|
            req.url uri + "/#{id}"
            req.headers['Content-Type'] = 'application/json'
            req.headers['Accept'] = "application/json"
            req.body = params.to_json
          end
          if response.status == 204
            new(params)
          else
            raise Error.new("Failed to update resource #{id}", response)
          end
        end

        def delete(id)
          response = conn.delete do |req|
            req.url uri + "/#{id}"
            req.headers['Content-Type'] = 'application/json'
            req.headers['Accept'] = "application/json"
          end
          if response.status == 204
            true
          else
            raise Error.new("Failed to delete resource #{id}", response) 
          end
        end

        def conn
          @conn ||= Faraday.new(base_url + self.uri) do |c|
            c.basic_auth(self.user, self.pass)
            c.request :json
            c.response :json, :content_type => /\bjson$/
            #c.response :logger
            c.use FaradayMiddleware::FollowRedirects
            c.adapter  :net_http
          end
        end
      end

      def initialize(attrs = {})
        @attributes = attrs.symbolize_keys
      end
      def [](field)
        @attributes[field]
      end

      def []=(field, val)
        @attributes[field] = val
      end

      def as_json(option = {})
        attributes
      end

      def update(attrs)
        response = self.class.conn.put do |req|
          req.url uri + "/#{id}"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = "application/json"
          req.body = attrs.to_json 
        end
        if response.status == 204 # no content
          attrs.each do |k, v|
            attributes[k] = v
          end
          true
        else
          raise Error.new("Failed to update resource #{id}", response)
        end
      end

      def delete
        response = self.class.conn.delete do |req|
          req.url uri + "/#{id}"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = "application/json"
        end
        if response.status == 204  # no content 
          true
        else
          raise Error.new("Failed to delete resource #{id}", response)
        end
      end

      def save
        update(attributes)
      end

      def method_missing(m, *args)
        if m.to_s[-1] == '='
          k = m.to_s[0..-2].to_sym
          if @attributes.keys.include?(k)
            @attributes[k] = args[0]
          else
            super
          end
        else
          if @attributes.keys.include?(m)
            @attributes[m]
          else
            super
          end
        end
      end
    end
    class Error < StandardError
      attr_accessor :response
      def initialize(msg = nil, response = nil)
        super(msg)
        self.response = response
      end
    end
  end
end

