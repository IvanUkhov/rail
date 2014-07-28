module Rail
  class Precompiler
    class Storage
      attr_reader :root

      def initialize(root = 'public')
        @root = root
      end

      def write(file, stream)
        file = File.join(root, file)

        unless File.exist?(File.dirname(file))
          FileUtils.mkdir_p(File.dirname(file))
        end

        File.open(file, 'w') do |file|
          stream.each { |chunk| file.write(chunk) }
        end
      end
    end

    class Logger
      def write(message)
        puts message
      end
    end

    def initialize(pipeline, options = {})
      @pipeline = pipeline
      @storage = options[:storage] || Storage.new
      @logger = options[:logger] || Logger.new
    end

    def process(paths)
      if paths.empty?
        logger.write('Nothing to precompile.')
        return
      end

      logger.write('Precompiling assets...')

      paths.each_with_index do |path, i|
        logger.write('%4d. %s' % [i + 1, path])
        storage.write(path, read(path))
      end

      logger.write('Done.')
    end

    private

    attr_reader :pipeline, :storage, :logger

    def read(path)
      request = Request.new('REQUEST_METHOD' => 'GET', 'PATH_INFO' => path)
      _, _, source = pipeline.process(request)
      source
    end
  end
end
