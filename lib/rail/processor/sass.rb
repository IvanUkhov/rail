module Rail
  module Processor
    class Sass < Base
      def self.input_extension
        'scss'
      end

      def self.output_extension
        'css'
      end

      def self.mime_type
        'text/css'
      end

      def compile(filename, options = {})
        options = {
          filename: filename,
          line: 1,
          syntax: :scss,
          style: compress? ? :compressed : :nested
        }.merge(options)

        engine = ::Sass::Engine.new(File.read(filename), options)
        engine.render
      end
    end
  end
end
