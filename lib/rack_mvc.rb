require "rack_mvc/version"

module RackMvc
  class Application
    def call
      [200, {"Content-Type"=>"text/html"}, ["hola!!"]]
    end
  end
end
