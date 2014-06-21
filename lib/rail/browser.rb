require 'rack'

module Rail
  class Browser
    extend Forwardable

    attr_reader :host
    def_delegator :host, :root

    attr_reader :directory
    def_delegator :directory, :call

    def initialize(host)
      @host = host
      @directory ||= Rack::Directory.new(File.join(root, 'public'))
    end

    def accept?(env)
      path = Support.extract_path(env)
      !path.empty? && File.exist?(File.join(root, 'public', path))
    end
  end
end
