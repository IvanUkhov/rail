module Rail
  module Processor
    class Base
      extend Forwardable

      def self.capable?(extension)
        Array(output_extension).include?(extension)
      end

      def self.extensify(filename)
        "#{filename}.#{input_extension}"
      end

      def self.token
        @token ||= Support::Inflector.underscorize(name.split('::').last).to_sym
      end

      attr_reader :pipeline
      def_delegator :pipeline, :compress?

      def initialize(pipeline)
        @pipeline = pipeline
      end
    end
  end
end
