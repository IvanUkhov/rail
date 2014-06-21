module Rail
  class Server < Rack::Server
    def initialize(options = nil)
      options = {
        Port: 3000,
        environment: Rail.env,
        config: 'config.ru'
      }.merge(options || {})

      super(options)
    end
  end
end
