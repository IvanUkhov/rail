require 'rack'

module Rail
  class Browser
    extend Forwardable

    def_delegator :@host, :root
    def_delegator :@directory, :call

    def initialize(host)
      @host = host
      @directory ||= Rack::Directory.new(File.join(root, 'public'))
    end

    def process(request)
      call(request.env)
    end

    def accept?(request)
      path = request.path
      !path.empty? && File.exist?(File.join(root, 'public', path))
    end
  end
end
