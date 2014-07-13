module Rail
  class Context
    def initialize(options = {})
      (options[:mixins] || []).each { |mixin| extend(mixin) }
      singleton_class.class_eval do
        (options[:locals] || {}).each do |name, value|
          define_method(name) { value }
        end
      end
    end
  end
end
