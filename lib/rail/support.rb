module Rail
  module Support
    def self.extract_path(env)
      env['PATH_INFO'].sub(/^\//, '').sub(/\?.*$/, '')
    end
  end
end
