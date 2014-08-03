module Support
  module Inflector
    def self.titelize(name)
      name = name.gsub(/[^\w ]/, '')
      name.gsub!(/^[^a-zA-Z]+/, '')
      name.gsub!(/_/, ' ')
      name.gsub!(/ {2,}/, ' ')
      name.gsub!(/ +$/, '')
      name.gsub!(/^\w| \w/, &:upcase)
      name
    end

    def self.modulize(name)
      name.split(/[\s_]+/).map(&:capitalize).join.to_sym
    end

    def self.underscorize(name)
      name = name.gsub(/[^\w]+/, ' ')
      name.gsub!(/([A-Z]+)/, ' \1')
      name.strip!
      name.gsub!(/ +/, '_')
      name.downcase!
      name
    end
  end
end
