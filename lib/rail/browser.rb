require 'rack'

module Rail
  class Browser
    attr_reader :root

    def initialize(config)
      @root = File.join(config.root, 'public')
      @directory = Rack::Directory.new(root)
    end

    def process(request)
      @directory.call(request.env)
    end

    def accept?(request)
      path = request.path
      !path.empty? && File.exist?(File.join(root, path))
    end
  end
end
