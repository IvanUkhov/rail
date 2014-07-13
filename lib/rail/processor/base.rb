module Rail
  module Processor
    class Base
      extend Forwardable

      def self.capable?(extension)
        Array(output_extension).include?(extension)
      end

      def self.extensify(filename)
        "#{ filename }.#{ input_extension }"
      end

      attr_reader :pipeline
      def_delegator :pipeline, :compress?

      def initialize(pipeline)
        @pipeline = pipeline
      end
    end
  end
end
