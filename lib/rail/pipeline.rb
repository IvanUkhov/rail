module Rail
  class Pipeline
    extend Forwardable

    def_delegators :@host, :root, :gems, :helpers, :compress?

    def initialize(host)
      @host = host
    end

    def process(request)
      context = Context.new(locals: { request: request }, mixins: helpers)

      asset = rewrite(request.path)
      klass = Processor.find(asset) or raise NotFoundError
      asset = klass.extensify(asset)
      filename = find(asset) or raise NotFoundError

      processor = klass.new(self)
      body = processor.compile(filename, context: context)

      headers = { 'Content-Type' => klass.mime_type }

      [ 200, headers, Array(body) ]
    rescue NotFoundError
      [ 404, {}, [] ]
    end

    def find(asset)
      paths.each do |path|
        filename = File.join(path, asset)
        return filename if File.exist?(filename)
      end
      nil
    end

    private

    def rewrite(path)
      if [ '', 'index.html' ].include?(path)
        'layouts/application.html'
      elsif File.extname(path).empty?
        "#{ path }.html"
      else
        path
      end
    end

    def paths
      @paths ||= (application_paths + gems.map { |gem| gem_paths(gem) }).flatten
    end

    def application_paths
      [
        File.join(root, 'app/assets/javascripts'),
        File.join(root, 'app/assets/stylesheets'),
        File.join(root, 'app/views')
      ]
    end

    def gem_paths(name)
      gem = Gem::Specification.find_by_name(name)
      [
        File.join(gem.gem_dir, 'lib/assets/javascripts'),
        File.join(gem.gem_dir, 'lib/assets/stylesheets')
      ]
    end
  end
end
