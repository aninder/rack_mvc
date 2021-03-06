require 'erubis'
require 'tilt/erubis'
require 'rack'

module RackMvc
  class Controller
    attr_reader :request, :response

    def initialize(env)
      @request = Rack::Request.new(env)
    end
    def render(view_name, variables)
      view = get_view(view_name, variables)
      setupResponse(200, {"content_type"=>"text/html"}, view)
    end
    #if action doesn't render call the default template,
    # action="default" then view_name="default.erb"
    def render_default_action_template(action)
      view = get_view(action)
      setupResponse(200, {"content_type"=>"text/html"}, view)
    end

    private
    def get_view(view_name, variables = {})
      add_instance_vars(variables)
      template_file = File.join("app", "views", get_current_controller_base_name, "#{view_name}.erb")
      template = Tilt::ErubisTemplate.new(template_file)
      view = template.render(Object.new, variables)
    end
    def add_instance_vars(variables)
      instance_variables.each do |var|
        key = var.to_s.gsub(/^@/,"").to_sym
        variables[key] = instance_variable_get(var)
      end
    end
    def get_current_controller_base_name
      #PagesController => pages
      self.class.to_s.gsub(/Controller$/,"").downcase
    end
    def setupResponse(status, header, body)
      @response = Rack::Response.new
      @response.body = [ body ]
      @response.header.merge!(header)
      @response.status = status
      @response.finish
    end
  end
end

