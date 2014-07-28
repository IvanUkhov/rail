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

    def initialize(pipeline, storage = nil)
      @pipeline = pipeline
      @storage = storage || Storage.new
    end

    def process(paths)
      if paths.empty?
        report('Nothing to precompile.')
        return
      end

      report('Precompiling assets...')

      paths.each_with_index do |path, i|
        report('%4d. %s' % [i + 1, path])
        storage.write(path, read(path))
      end

      report('Done.')
    end

    private

    attr_reader :pipeline, :storage

    def read(path)
      request = Request.new('REQUEST_METHOD' => 'GET', 'PATH_INFO' => path)
      _, _, source = pipeline.process(request)
      source
    end

    def report(message)
      puts message
    end
  end
end
