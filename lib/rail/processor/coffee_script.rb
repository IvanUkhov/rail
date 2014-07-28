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

      def compile(filename, options = {})
        code = process(filename, options)
        code = Uglifier.new.compile(code) if compress?
        code
      end

      private

      def process(filename, options = {})
        output = []

        code = File.read(filename)

        extract_requirements(code).each do |name|
          requirement_filename = find_requirement(name, filename)
          raise NotFoundError unless requirement_filename
          output << compile(requirement_filename, options)
        end

        output << ::CoffeeScript.compile(code, options)

        output.join
      end

      def find_requirement(name, referrer)
        assets = [name, "#{name}.coffee", "#{name}.js.coffee"]

        if name =~ /^\.\// # relative?
          path = File.dirname(referrer)
          assets.each do |asset|
            filename = File.join(path, asset)
            return filename if File.exist?(filename)
          end
        else
          assets.each do |asset|
            filename = pipeline.find(asset)
            return filename if filename
          end
        end

        nil
      end

      def extract_requirements(code)
        match = /\A(?:\s*(?:\#.*\n?)+)+/.match(code) or return []
        match[0].split(/\n/).map(&:strip).reject(&:empty?).map do |line|
          match = /^\s*\#\s*=\s*require\s+(.*)$/.match(line)
          match ? match[1].strip.gsub(/(^['"])|(['"]$)/, '') : nil
        end.compact
      end
    end
  end
end
