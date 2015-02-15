require "rack_mvc/version"
require "rack_mvc/controller"
require "pry"
#$LOAD_PATH << File.join(File.dirname(__FILE__),"..","app","controllers")
$LOAD_PATH << File.join("app","controllers")

module RackMvc

  class Application
    def call(env)
      response = Rack::Response.new
      if request.path_info == "/"
        response.status = 302
        response.header["location"] = "/pages/check"
        response.body = []
        return response.finish
      end
      _,controller_class,action = request.path_info.split("/")
      controller = self.class.const_get(controller_class.capitalize+"Controller").new
      response.header["content_type"] = "/text/html"
      response.body = [ controller.send(action) ]
      response.status = 200
      response.finish
    end
    def self.const_missing(const)
      require const.to_s.gsub(/^([A-Z][a-z]+)([A-Z][a-z]+)/,'\1_\2').downcase
      const_get(const)
    end
  end
end
