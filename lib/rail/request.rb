module Rail
  class Request
    attr_reader :env

    def initialize(env)
      @env = rewrite(env)
    end

    def path
      env['PATH_INFO']
    end

    def host
      env['HTTP_HOST']
    end

    private

    def rewrite(env)
      path = env['PATH_INFO']
      path = '/index.html' if [nil, '', '/'].include?(path)
      path = "#{path}.html" if File.extname(path).empty?
      env['PATH_INFO'] = path
      env
    end
  end
end
