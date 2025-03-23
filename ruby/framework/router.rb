class Router
  attr_reader :routes

  def initialize
    @routes = Route.new.routes
  end

  def dispatch(path)
    if routes.has_key?(path.to_sym)
      controller(routes[path.to_sym]).call
    else
      Controller.new.not_found
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private

  def controller(string)
    controller_name, action_name = string.split('#')
    klass = Object.const_get "#{controller_name.capitalize}Controller"
    klass.new(name: controller_name, action: action_name.to_sym)
  end
end
