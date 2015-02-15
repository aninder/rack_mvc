require 'erubis'
require 'tilt/erubis'

module RackMvc
  class Controller
    attr_reader request

    def initialize(env)
      @request = Rack::Request.new(env)
    end
    def render(view_name, variables)
      template_file = File.join("app", "views", self.class.to_s.gsub(/Controller$/,"").downcase, "#{view_name}.erb")
      template = Tilt::ErubisTemplate.new(template_file)          
      template.render(Object.new, variables)
    end
  end
end

