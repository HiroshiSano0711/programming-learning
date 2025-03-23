class AssetsController < Controller
  def call
    res_contents = send(action)
    self.status = 200
    self.headers = {"Content-Type" => "text/css"}
    self.content = [res_contents]
    self
  end

  def index
    File.read(File.join(App.project_root, 'app', 'assets', 'style.css'))
  end
end
