module Rail
  class Application
    extend Forwardable

    attr_reader :browser, :pipeline
    def_delegators :config, :root, :gems, :compress?

    def initialize
      # config/application.rb
      config.root ||= File.expand_path('..', caller[0].sub(/:.*/, ''))

      @browser = Browser.new(self)
      @pipeline = Pipeline.new(self)
    end

    def call(env)
      (browser.accept?(env) ? browser : pipeline).call(env)
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

    private

    def load_helpers
      Dir[File.join(root, 'app/helpers/*.rb')].map do |file|
        require file
        Support.constantize(File.basename(file, '.rb'))
      end
    end

    def self.load_tasks
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each do |path|
        Rake::load_rakefile(path)
      end
    end

    def self.default_options
      {
        gems: [],
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
  end
end
