require 'erubis'
require 'tilt/erubis'

module RackMvc
  class Controller
    def render(view_name, variables)
      template_file = File.join(File.dirname(__FILE__), "..", "..", "app", "views", self.class.to_s.gsub(/Controller$/,"").downcase, "#{view_name}.erb")
      template = Tilt::ErubisTemplate.new(template_file)          
      template.render(Object.new, variables)
    end
  end
end

