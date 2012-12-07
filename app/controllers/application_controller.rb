class ApplicationController < ActionController::Base
 	protect_from_forgery
 	include SessionsHelper

 	before_filter :populate_site_info
 	before_filter :populate_articles

 	protected
 		def populate_site_info
 			@site_info = SiteInfo.all[0]
 		end
 		def populate_articles
 			@articles = Article.all
 		end
end
