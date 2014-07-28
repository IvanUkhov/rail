require 'generator'

module Rail
  class Generator < ::Generator
    Error = Class.new(StandardError)

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

      project_name = (destination.split('/').last || '')
        .gsub(/^[^a-zA-Z]*/, '')
        .gsub(/[^\w]/, '')
        .gsub(/^\w|_\w/, &:upcase)
        .gsub(/_+/, ' ')

      class_name = project_name.gsub(' ', '')

      @locals = { class_name: class_name, project_name: project_name }

      raise Error, 'The project name is invalid.' if class_name.empty?

      super(destination: destination, source: source)
    end

    def run
      if File.directory?(destination)
        raise Error, 'The directory already exists.'
      end
      process(FILES, @locals)
    end
  end
end
