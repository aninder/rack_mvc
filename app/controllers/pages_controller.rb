#require_relative "../../lib/rack_mvc/controller" 

class PagesController < RackMvc::Controller
  def check
    render(:default, con:"pages controller")
  end
end

