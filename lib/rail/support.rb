module Rail
  module Support
    def self.extract_path(env)
      env['PATH_INFO'].sub(/^\//, '').sub(/\?.*$/, '')
    end

    def self.constantize(name)
      const_get(name.split(/[\s_]+/).map(&:capitalize).join)
    end
  end
end
