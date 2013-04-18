class ArticlesController < ApplicationController
    before_filter :signed_in_user,  only: [:index, :new, :create, :edit, :update, :destroy]
    before_filter :privileged_user, only: [:index, :new, :create, :edit, :update, :destroy]

    def new
        @article = Article.new
        @user = current_user
    end

    def create
        @article = Article.new(params[:article])
        @user = current_user
        if @article.save
            flash[:success] = "Article created"
            redirect_to articles_path
        else
            render 'new'
        end   
    end

    def edit
        @article = Article.find(params[:id])
        @user = current_user
    end

    def update
        @article = Article.find(params[:id])
        @user = current_user
        if @article.update_attributes(params[:article])
            flash[:success] = "Article updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def index
        @filter = params[:filter]
        if params[:filter] == 'frontpage'
            @articles = Article.where(:frontpage => true).paginate(page: params[:page],
                                                                :per_page => 20)
        elsif params[:filter] == 'news'
            @articles = Article.where("menu IS NULL OR menu == '' ").paginate(page: params[:page],
                                                                :per_page => 20)
        elsif params[:filter] == 'menus'
            @articles = Article.where("menu IS NOT NULL AND menu != '' ").paginate(page: params[:page],
                                                                :per_page => 20)
        else    # filter is 'all' or no filter specified
            @articles = Article.paginate(page: params[:page], :per_page => 20)
        end
        count = @articles.length
    end

    def show
        @article = Article.find(params[:id])
    end

    def destroy
        Article.find(params[:id]).destroy
        flash[:success] = "Article deleted."
        redirect_to articles_path
    end

end

