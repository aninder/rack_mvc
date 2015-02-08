require "rack_mvc/version"
require "rack_mvc/controller"

module RackMvc
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [302, {"location"=>"/pages/check"}, []]
      end
      _,controller_class,action = env["PATH_INFO"].split("/") 
      response = Object.const_get(controller_class.capitalize+"Controller").new.send(action)
      [200, {"Content-Type"=>"text/html"}, [response] ]
    end
  end
end
