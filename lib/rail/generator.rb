require 'erb'
require 'ostruct'
require 'fileutils'

module Rail
  class Generator
    attr_reader :root_dir, :template_dir

    def initialize(options)
      @root_dir = options.fetch(:root_dir)
      @template_dir = options.fetch(:template_dir)
    end

    def process(files, locals = {})
      context = OpenStruct.new(locals)
      files.each { |file| process_one(file, context) }
    end

    private

    def process_one(file, context)
      source = find(file)
      destination = route(file)

      directory = File.dirname(destination)
      unless File.directory?(directory)
        report("Creating a directory: #{ directory }")
        make(directory)
      end

      report("Creating a file: #{ destination }")
      if template?(file)
        dump(transform(load(source), context), destination)
      else
        copy(source, destination)
      end
    end

    def template?(file)
      File.extname(file) == '.erb'
    end

    def find(file)
      File.join(template_dir, file)
    end

    def route(file)
      File.join(root_dir, file).gsub(/\.erb$/, '')
    end

    def report(message)
      puts message
    end

    def make(destination)
      FileUtils.mkdir_p(destination)
    end

    def copy(source, destination)
      FileUtils.cp(source, destination)
    end

    def load(source)
      File.read(source)
    end

    def dump(content, destination)
      File.open(destination, 'w') { |file| file.write(content) }
    end

    def transform(content, context)
      context.singleton_class.class_eval('def get_binding; binding; end')
      ERB.new(content).result(context.get_binding)
    end
  end
end
