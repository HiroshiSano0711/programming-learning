class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name:, method:, action:)
    @name = name
    @method = method
    @action = action
  end

  def render(target_file_name)
    Slim::Template.new(
      File.join(AppConfig.project_path, 'app', 'views', "application.slim")
    ).render(self)
  end

  def embed_view
    Slim::Template.new(
      File.join(AppConfig.project_path, 'app', 'views', "#{name}", "#{action}.slim")
    ).render(self)
  end

  def call
    res_contents = send(action)
    self.status = 200
    self.headers = {"Content-Type" => "text/html"}
    self.content = [res_contents]
    self
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Not found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
    self
  end
end
