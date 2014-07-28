module Support
  class QueryString < String
    def method_missing(name, *arguments, &block)
      return super unless name.to_s =~ /^(?<name>.+)\?$/
      self == Regexp.last_match(:name)
    end
  end
end
