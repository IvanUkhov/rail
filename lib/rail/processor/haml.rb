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
          ugly: options[:compress]
        }.merge(options)

        engine = ::Haml::Engine.new(File.read(filename), options)

        layout_filename = find_layout(filename, options)

        if layout_filename
          compile(layout_filename, options) do
            engine.render(options[:context], {}, &block)
          end
        else
          engine.render(options[:context], {}, &block)
        end
      end

      def self.find_layout(filename, options)
        asset = "layouts/#{ filename.split('/')[-2] }"

        [ "#{ asset }.haml", "#{ asset }.html.haml" ].each do |asset|
          filename = options[:pipeline].find(asset)
          return filename if filename
        end

        nil
      end

      private_class_method :find_layout
    end
  end
end
