require_relative 'processor/base'
require_relative 'processor/coffee_script'
require_relative 'processor/haml'
require_relative 'processor/sass'

module Rail
  module Processor
    def self.classes
      @classes ||= Processor.constants.map do |name|
        object = Processor.const_get(name)
        object.is_a?(Class) && object < Base ? object : nil
      end.compact
    end

    def self.find(filename)
      extension = File.extname(filename).slice(1..-1)
      classes.find { |processor| processor.capable?(extension) }
    end
  end
end
