module Rail
  class Request
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def path
      @path ||= env['PATH_INFO'].gsub(/(^\/)|(\?.*$)/, '')
    end

    def host
      env['HTTP_HOST']
    end
  end
end
