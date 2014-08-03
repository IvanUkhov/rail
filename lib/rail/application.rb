module Rail
  class Application
    attr_reader :config, :browser, :pipeline

    def initialize
      @config = self.class.config
      @browser = Browser.new(config)
      @pipeline = Pipeline.new(config)
    end

    def call(env)
      request = Request.new(env)
      (browser.accept?(request) ? browser : pipeline).process(request)
    end

    def precompile
      Precompiler.new(pipeline).process(config.precompile)
    end

    def self.inherited(klass)
      klass.config.root = File.expand_path('../..', caller[0].sub(/:.*/, ''))
    end

    def self.config
      @config ||= Support::QueryStruct.new(default_options).tap do |config|
        Processor.classes.each do |klass|
          config[klass.token] = Support::QueryStruct.new
        end
      end
    end

    def self.load_tasks
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each do |path|
        Rake::load_rakefile(path)
      end
    end

    private

    def self.default_options
      { gems: [], precompile: [], compress: Rail.env.production?  }
    end
  end
end
