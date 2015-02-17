require "rack_mvc/version"
require "rack_mvc/controller"
require "pry"
#$LOAD_PATH << File.join(File.dirname(__FILE__),"..","app","controllers")
$LOAD_PATH << File.join("app","controllers")

class String
  def to_snake_case
    self.gsub(/^([A-Z][a-z]+)([A-Z][a-z]+)/,'\1_\2').downcase
  end
end

module RackMvc
  class Application
    def call(env)
      # redirect_base_address_to_default_page
      if env["PATH_INFO"] == "/"
        return redirect_base_url_to_default_page
      end
      _,controller_class,action = env["PATH_INFO"].split("/")
      controller_class = self.class.const_get(controller_class.capitalize+"Controller")
      controller = controller_class.new(env)
      controller.send(action)
      if controller.response
        return controller.response
        #no rendering done by action,use the template same as action name
      else
        #render default action template if no rendering done
        controller.render_default_action_template(action)
        return controller.response
      end
    end
    def self.const_missing(const)
      require const.to_s.to_snake_case
      const_get(const)
    end
    def redirect_base_url_to_default_page
      response = Rack::Response.new
      response.status = 302
      response.body = []
      response.header["location"] = "/pages/default"
      response.finish
      return response
    end
  end
end
