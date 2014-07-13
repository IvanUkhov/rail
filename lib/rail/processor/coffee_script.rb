module Rail
  module Processor
    class CoffeeScript < Base
      def self.input_extension
        'coffee'
      end

      def self.output_extension
        'js'
      end

      def self.mime_type
        'application/javascript'
      end

      def self.compile(filename, options = {})
        code = process(filename, options)
        code = Uglifier.new.compile(code) if options[:compress]
        code
      end

      def self.process(filename, options = {})
        output = []

        code = File.read(filename)
        path = File.dirname(filename)

        extract_requirements(code).each do |requirement|
          output << compile(find(path, requirement), options)
        end

        output << ::CoffeeScript.compile(code, options)

        output.join
      end

      def self.find(path, requirement)
        filename = File.join(path, requirement)
        [ filename,
          "#{ filename }.coffee",
          "#{ filename }.js.coffee"
        ].find do |filename|
          File.exist?(filename)
        end
      end

      def self.extract_requirements(code)
        match = /\A(?:\s*(?:\#.*\n?)+)+/.match(code) or return []
        match[0].split(/\n/).map(&:strip).reject(&:empty?).map do |line|
          match = /^\s*\#\s*=\s*require\s+(.*)$/.match(line)
          match ? match[1].strip.gsub(/(^['"])|(['"]$)/, '') : nil
        end.compact
      end

      private_class_method :process, :extract_requirements
    end
  end
end
