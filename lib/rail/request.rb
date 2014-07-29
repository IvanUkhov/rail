module Rail
  class Request
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def path
      @path ||= rewrite(strip(env['PATH_INFO']))
    end

    def host
      env['HTTP_HOST']
    end

    private

    def strip(path)
      path.gsub(/(^\/)|(\?.*$)/, '')
    end

    def rewrite(path)
      path = 'index.html' if path.empty?
      path = "#{path}.html" if File.extname(path).empty?
      path
    end
  end
end
