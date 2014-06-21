module Rail
  module Support
    def self.constantize(name)
      const_get(name.split(/[\s_]+/).map(&:capitalize).join)
    end
  end
end
