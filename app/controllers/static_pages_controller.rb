class StaticPagesController < ApplicationController
	def home
		@topstories = Article.where(:frontpage => true).order("rank DESC", 
															  "updated_at DESC")
	end
end
