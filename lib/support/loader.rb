require 'support/inflector'

module Support
  class Loader
    def initialize(pattern)
      @pattern = pattern
      @files = []
      @names = []
    end

    def reload?
      !last_scanned || !last_loaded || last_loaded < last_modified
    end

    def find
      scan!

      if reload?
        unload!
        load!
      end

      modules
    end

    private

    attr_reader :pattern, :files, :names, :modules
    attr_reader :last_scanned, :last_loaded

    def scan!
      @last_scanned = Time.now
      @files = Dir[pattern]
    end

    def last_modified
      files.map { |file| File.mtime(file) }.max
    end

    def unload!
      names.each { |name| Object.send(:remove_const, name) }
      names.clear
    end

    def load!
      @names = files.map do |file|
        load file
        Support::Inflector.modulize(File.basename(file, '.rb'))
      end

      @modules = names.map { |name| Object.const_get(name) }
      @last_loaded = last_scanned
    end
  end
end
