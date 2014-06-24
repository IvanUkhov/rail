module Rail
  class Pipeline
    extend Forwardable

    def_delegators :@host, :root, :gems, :helpers, :compress?

    def initialize(host)
      @host = host
    end

    def process(request)
      Thread.current[:request] = request

      path = request.path

      case path
      when '', 'index.html'
        path = 'layouts/application'
      end

      path = "#{ path }.html" if File.extname(path).empty?

      sprockets.call('PATH_INFO' => path)
    end

    private

    def sprockets
      @sprockets ||= build_sprockets
    end

    def build_sprockets
      environment = Sprockets::Environment.new

      paths.each do |directory|
        environment.append_path(directory)
      end

      if compress?
        environment.js_compressor = :uglify
        environment.css_compressor = :scss
      end

      # TODO: Find a per-instance way to configure HAML.
      Haml::Options.defaults[:ugly] = compress?

      helpers.each do |helper|
        environment.context_class.class_eval do
          include helper
        end
      end

      environment.context_class.class_eval do
        define_method(:request) do
          Thread.current[:request]
        end
      end

      environment
    end

    def paths
      (application_paths + gems.map { |name| gem_paths(name) }).flatten
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
