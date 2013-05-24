class StaticPagesController < ApplicationController
    before_filter :signed_in_user, only: [:content]
    before_filter :privileged_user, only: [:content]

	def home
		@articles = Article.where(:frontpage => true, :publish => true).order("rank DESC",
                                                          "updated_at DESC")
	end

    def news
        @articles = Article.published.where("(menu IS NULL OR menu = '') ").order("rank DESC",
        #@articles = Article.where(:menu.blank? => true).order("rank DESC",
                                           "updated_at DESC").paginate(page: params[:page],
                                                                       :per_page => 10)
    end

    def blog
        @articles = Article.published.where("menu = 'Blog' ").order("rank DESC",
                                "updated_at DESC").paginate(page: params[:page], :per_page => 10)
    end

    def article_set
        @title = params[:title]
        target_menu = params[:menu_path]
        @articles = Article.where("menu LIKE ?", target_menu).order("rank DESC")
    end
    
    def content
    end

    def calendar
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        @events = Event.all
    end
end
