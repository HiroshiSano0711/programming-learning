Dir[File.join(File.dirname(__FILE__), './', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'MyApp', '**', '*.rb')].each {|file| require file }

class App
  attr_reader :router

  def initialize
    @router = Router.new
  end

  def self.root
    File.dirname(__FILE__)
  end

  def self.project_root
    "#{File.dirname(__FILE__)}/MyApp"
  end

  def call(env)
    result = router.dispatch(env['REQUEST_PATH'])
    [result.status, result.headers, result.content]
  end
end
