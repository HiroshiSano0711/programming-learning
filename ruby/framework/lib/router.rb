# frozen_string_literal: true

class Router
  class << self
    @@routes = {}

    def draw_routes(&block)
      instance_eval(&block)
    end

    def root(to:)
      @@routes[:/] = to
    end

    def get(path, to:)
      @@routes[:"#{path}"] = to
    end
  end

  def dispatch(request_path:, request_method:)
    if @@routes.key?(request_path.to_sym)
      controller_class(path: @@routes[request_path.to_sym], method: request_method).call
    else
      Controller.new.not_found
    end
  rescue StandardError => e
    puts e.message
    puts e.backtrace
    Controller.new.internal_error
  end

  private

  def controller_class(path:, method:)
    controller_name, action_name = path.split('#')
    klass = Object.const_get "#{controller_name.capitalize}Controller"
    klass.new(name: controller_name, method: method, action: action_name.to_sym)
  end
end
