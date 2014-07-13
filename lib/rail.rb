require 'ostruct'
require 'forwardable'

require 'rack'

require 'coffee-script'
require 'haml'
require 'sass'

require 'uglifier'

require_relative 'rail/application'
require_relative 'rail/browser'
require_relative 'rail/context'
require_relative 'rail/pipeline'
require_relative 'rail/processor'
require_relative 'rail/request'
require_relative 'rail/server'
require_relative 'rail/support'
require_relative 'rail/version'

module Rail
  NotFoundError = Class.new(StandardError)

  def self.env
    @env ||= build_env
  end

  def self.applications
    ObjectSpace.each_object(Class).select do |klass|
      klass < Application
    end
  end

  private

  def self.build_env
    string = ENV['RAIL_ENV'] ? ENV['RAIL_ENV'].dup : 'development'

    string.singleton_class.class_eval do
      define_method(:method_missing) do |name, *arguments, &block|
        super unless name.to_s =~ /^(?<name>.+)\?$/
        self == Regexp.last_match(:name)
      end
    end

    string
  end
end
