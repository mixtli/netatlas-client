class NetAtlas::BasicAuthMiddleware < Faraday::Middleware
  def initialize(adapter, credentials)
    @credentials = credentials
    super(adapter)
  end

  def call(env)
    env[:request_headers]['Authorization'] = "Basic " + Base64.encode64("#{@credentials[:user]}:#{@credentials[:password]}")
    @app.call(env)
  end
end
