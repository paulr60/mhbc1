class StaticPagesController < ApplicationController
    before_filter :signed_in_user, only: [:content]
    before_filter :privileged_user, only: [:content]

	def home
		@topstories = Article.where(:frontpage => true).order("rank DESC", 
															  "updated_at DESC")
	end
    def content
        
    end
end
