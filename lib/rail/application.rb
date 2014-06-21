module Rail
  class Application
    extend Forwardable

    attr_reader :browser, :pipeline
    def_delegators :config, :root, :gems, :compress?

    def initialize
      # config.ru
      config.root ||= self.class.find_root

      @browser = Browser.new(self)
      @pipeline = Pipeline.new(self)
    end

    def call(env)
      request = Request.new(env)
      (browser.accept?(request) ? browser : pipeline).process(request)
    end

    def helpers
      @helpers ||= load_helpers
    end

    def config
      self.class.config
    end

    def self.config
      @config ||= build_config
    end

    def self.load_tasks
      # Rakefile
      config.root ||= find_root

      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each do |path|
        Rake::load_rakefile(path)
      end
    end

    def self.precompile
      return if config.precompile.empty?

      application = self.new

      puts 'Precompiling assets...'
      puts

      config.precompile.each do |path|
        file = File.join('public', path)
        unless File.exist?(File.dirname(file))
          FileUtils.mkdir_p(File.dirname(file))
        end

        puts "#{ path } -> #{ file }"

        _, _, source = application.call('PATH_INFO' => path)

        File.open(file, 'w') { |f| f.write(source.to_s) }
      end

      puts
      puts 'Done.'
    end

    def self.find_root
      File.expand_path('..', caller[1].sub(/:.*/, ''))
    end

    private

    def load_helpers
      Dir[File.join(root, 'app/helpers/*.rb')].map do |file|
        require file
        Support.constantize(File.basename(file, '.rb'))
      end
    end

    def self.default_options
      {
        gems: [],
        precompile: [],
        compress: Rail.env.production?
      }
    end

    def self.build_config
      struct = OpenStruct.new

      struct.singleton_class.class_eval do
        define_method(:method_missing) do |name, *arguments, &block|
          !!super(name.to_s.sub(/\?$/, '').to_sym, *arguments, &block)
        end
      end

      default_options.each do |name, value|
        struct.send("#{ name }=", value)
      end

      struct
    end

    private_class_method :default_options, :build_config
  end
end
