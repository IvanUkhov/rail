require 'forwardable'
require 'rack'
require 'coffee-script'
require 'haml'
require 'sass'
require 'uglifier'

require_relative 'support/inflector'
require_relative 'support/loader'
require_relative 'support/query_string'
require_relative 'support/query_struct'

require_relative 'rail/application'
require_relative 'rail/browser'
require_relative 'rail/context'
require_relative 'rail/pipeline'
require_relative 'rail/precompiler'
require_relative 'rail/processor'
require_relative 'rail/request'
require_relative 'rail/server'
require_relative 'rail/version'

module Rail
  NotFoundError = Class.new(StandardError)

  def self.env
    @env ||= Support::QueryString.new(ENV['RAIL_ENV'] || 'development')
  end

  def self.applications
    ObjectSpace.each_object(Class).select do |klass|
      klass < Application
    end
  end
end
