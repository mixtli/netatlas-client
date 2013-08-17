class NetAtlas::BasicAuthMiddleware < Faraday::Middleware
  def initialize(credientials)
    @credentials = credentials
    super
  end

  def call(env)
    env[:request_headers]['Authorization'] = "Basic " + Base64.encode("#{@credentials[:user]}:#{@credentials[:pass]}")
  end
end
