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
      root_dir = options.fetch(:root_dir)
      template_dir = File.expand_path('../templates', __FILE__)

      project_name = root_dir.split('/').last
        .gsub(/^[^a-zA-Z]*/, '')
        .gsub(/[^\w]/, '')
        .gsub(/^\w|_\w/, &:upcase)
        .gsub(/_+/, ' ')

      class_name = project_name.gsub(' ', '')

      @locals = { class_name: class_name, project_name: project_name }

      raise Error('The project name is invalid.') if class_name.empty?

      super(root_dir: root_dir, template_dir: template_dir)
    end

    def run
      raise Error('The directory already exists.') if File.directory?(root_dir)
      super(FILES, @locals)
    end

    def report(message)
      puts "Creating '#{ message }'..."
    end
  end
end
