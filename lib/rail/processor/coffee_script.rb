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

        extract_requirements(code).each do |name|
          requirement_filename = find_requirement(name, filename, options)
          raise NotFoundError unless requirement_filename
          output << compile(requirement_filename, options)
        end

        output << ::CoffeeScript.compile(code, options)

        output.join
      end

      def self.find_requirement(name, referrer, options)
        assets = [ name, "#{ name }.coffee", "#{ name }.js.coffee" ]

        if name =~ /^\.\// # relative?
          path = File.dirname(referrer)
          assets.each do |asset|
            filename = File.join(path, asset)
            return filename if File.exist?(filename)
          end
        else
          assets.each do |asset|
            filename = options[:pipeline].find(asset)
            return filename if filename
          end
        end

        nil
      end

      def self.extract_requirements(code)
        match = /\A(?:\s*(?:\#.*\n?)+)+/.match(code) or return []
        match[0].split(/\n/).map(&:strip).reject(&:empty?).map do |line|
          match = /^\s*\#\s*=\s*require\s+(.*)$/.match(line)
          match ? match[1].strip.gsub(/(^['"])|(['"]$)/, '') : nil
        end.compact
      end

      private_class_method :process, :extract_requirements, :find_requirement
    end
  end
end
