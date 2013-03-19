class StaticPagesController < ApplicationController
    before_filter :signed_in_user, only: [:content]
    before_filter :privileged_user, only: [:content]

	def home
		@articles = Article.where(:frontpage => true).order("rank DESC",
															  "updated_at DESC")
	end

    def foo
        @articles = Article.paginate(page: params[:page], :per_page => 10)
    end
    def news
        debugger
        @articles = Article.where("menu IS NULL OR menu == '' ").order("rank DESC",
                                           "updated_at DESC").paginate(page: params[:page],
                                                                       :per_page => 10)
    end
    
    def content
    end
end
