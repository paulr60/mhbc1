class ApplicationController < ActionController::Base
 	protect_from_forgery
 	include SessionsHelper

 	before_filter :populate_site_info

 	protected
 		def populate_site_info
 			@site_info = SiteInfo.all[0]
 		end
end
