class ApplicationController < ActionController::Base
 	protect_from_forgery
 	include SessionsHelper

 	before_filter :populate_site_info
 	before_filter :populate_articles
    before_filter :reset_menu_system

 	protected
 		def populate_site_info
 			@site_info = SiteInfo.all[0]
 		end
 		def populate_articles
 			@all_articles = Article.all
 		end
        def reset_menu_system
            @ms = MenuSystem.reset
        end
end
