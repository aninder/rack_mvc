require "rack_mvc/version"
require "rack_mvc/controller"
#$LOAD_PATH << File.join(File.dirname(__FILE__),"..","app","controllers")
$LOAD_PATH << File.join("app","controllers")

module RackMvc
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [302, {"location"=>"/pages/check"}, []]
      end
      _,controller_class,action = env["PATH_INFO"].split("/") 
      response = self.class.const_get(controller_class.capitalize+"Controller").new.send(action)
      [200, {"Content-Type"=>"text/html"}, [response] ]
    end
    def self.const_missing(const)
      require const.to_s.gsub(/^([A-Z][a-z]+)([A-Z][a-z]+)/,'\1_\2').downcase
      const_get(const)
    end
  end
end
