require 'ostruct'

module Support
  class QueryStruct < OpenStruct
    def merge(options = {})
      self.class.new(self.to_h.merge(options.to_h))
    end

    def method_missing(name, *arguments, &block)
      return super unless name.to_s =~ /^(?<name>.+)\?$/
      !!super(Regexp.last_match(:name).to_sym, *arguments, &block)
    end
  end
end
