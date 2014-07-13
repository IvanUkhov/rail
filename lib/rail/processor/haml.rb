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

      def compile(filename, options = {}, &block)
        options = {
          filename: filename,
          line: 1,
          ugly: compress?
        }.merge(options)

        engine = ::Haml::Engine.new(File.read(filename), options)

        layout_filename = find_layout(filename)

        if layout_filename
          compile(layout_filename, options) do
            engine.render(options[:context], {}, &block)
          end
        else
          engine.render(options[:context], {}, &block)
        end
      end

      private

      def find_layout(filename)
        asset = "layouts/#{ filename.split('/')[-2] }"

        [ "#{ asset }.haml", "#{ asset }.html.haml" ].each do |asset|
          filename = pipeline.find(asset)
          return filename if filename
        end

        nil
      end
    end
  end
end
