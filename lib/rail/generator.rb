require 'support/generator'
require 'support/inflector'

module Rail
  class Generator < Support::Generator
    FILES = [
      'app/assets/javascripts/application.js.coffee',
      'app/assets/stylesheets/application.css.scss',
      'app/helpers/application_helper.rb',
      'app/views/layouts/application.html.haml.erb',
      'config/application.rb.erb',
      'config.ru.erb',
      'Gemfile',
      'public/favicon.png',
      'Rakefile.erb'
    ]

    def initialize(options)
      destination = options.fetch(:destination)
      source = File.expand_path('../templates', __FILE__)

      directory = destination.split('/').last || ''
      project_name = Support::Inflector.titelize(directory)
      class_name = project_name.gsub(' ', '')

      @locals = { class_name: class_name, project_name: project_name }

      raise ArgumentError, 'The project name is invalid.' if class_name.empty?

      super(destination: destination, source: source)
    end

    def run
      if File.directory?(destination)
        raise ArgumentError, 'The directory already exists.'
      end
      process(FILES, @locals)
    end
  end
end
