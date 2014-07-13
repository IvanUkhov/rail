module Rail
  module Processor
    class Haml < Base
      def self.input_extension
        'haml'
      end

      def self.output_extension
        'html'
      end

      def self.mime_type
        'text/html'
      end

      def self.compile(filename, options = {}, &block)
        options = {
          filename: filename,
          line: 1,
          ugly: options[:compressed]
        }.merge(options)

        engine = ::Haml::Engine.new(File.read(filename), options)
        engine.render(options[:scope], options[:locals] || {}, &block)
      end
    end
  end
end
