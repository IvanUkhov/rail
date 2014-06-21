require_relative 'config/application'

class Controller
  def initialize(&block)
    Project::Application.class_eval(&block) if block
    @application = Project::Application.new
  end

  def process(path)
    _, _, body = @application.call('PATH_INFO' => path)
    body.to_s
  end
end
