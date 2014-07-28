module Support
  module Inflector
    def self.titelize(name)
      name.gsub(/[^\w ]/, '')
          .gsub(/^[^a-zA-Z]+/, '')
          .gsub(/_/, ' ')
          .gsub(/ {2,}/, ' ')
          .gsub(/ +$/, '')
          .gsub(/^\w| \w/, &:upcase)
    end

    def self.constantize(name)
      const_get(name.split(/[\s_]+/).map(&:capitalize).join)
    end
  end
end
