require 'erb'
require 'ostruct'
require 'fileutils'

class Generator
  attr_reader :destination, :source

  def initialize(options)
    @destination = options.fetch(:destination)
    @source = options.fetch(:source)
  end

  def process(files, locals = {})
    context = OpenStruct.new(locals)
    files.each { |file| process_one(file, context) }
  end

  private

  def process_one(file, context)
    output_file = find(file)
    input_file = route(file)

    directory = File.dirname(input_file)
    unless File.directory?(directory)
      report(directory)
      make(directory)
    end

    report(input_file)
    if template?(file)
      dump(transform(load(output_file), context), input_file)
    else
      copy(output_file, input_file)
    end
  end

  def template?(file)
    File.extname(file) == '.erb'
  end

  def find(file)
    File.join(source, file)
  end

  def route(file)
    File.join(destination, file).gsub(/\.erb$/, '')
  end

  def report(message)
  end

  def make(directory)
    FileUtils.mkdir_p(directory)
  end

  def copy(output_file, input_file)
    FileUtils.cp(output_file, input_file)
  end

  def load(file)
    File.read(file)
  end

  def dump(content, file)
    File.open(file, 'w') { |file| file.write(content) }
  end

  def transform(content, context)
    context.singleton_class.class_eval('def get_binding; binding; end')
    ERB.new(content).result(context.get_binding)
  end
end
