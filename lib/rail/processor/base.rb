module Rail
  module Processor
    class Base
      def self.capable?(extension)
        Array(output_extension).include?(extension)
      end

      def self.extensify(filename)
        "#{ filename }.#{ input_extension }"
      end
    end
  end
end
