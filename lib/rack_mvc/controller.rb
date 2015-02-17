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
      template_file = File.join("app", "views", get_current_controller_base_name, "#{view_name}.erb")
      template = Tilt::ErubisTemplate.new(template_file)
      view = template.render(Object.new, variables)
      setupResponse(view)
    end
    def setupResponse(view)
      @response = Rack::Response.new
      @response.body = [ view ]
      @response.header["content_type"] = "/text/html"
      @response.status = 200
      @response.finish
    end
    #
    def render_default_action_template
      @response = Rack::Response.new
      @response.status = 200
      @response.body = ["no rendering done"]
      @response.finish
      return @response
    end

    private
    def get_current_controller_base_name
      #PagesController => pages
      self.class.to_s.gsub(/Controller$/,"").downcase
    end
  end
end

