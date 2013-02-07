class ArticlesController < ApplicationController
    before_filter :signed_in_user,  only: [:index, :new, :create, :edit, :update, :destroy]
    before_filter :privileged_user, only: [:index, :new, :create, :edit, :update, :destroy]

    def new
        @article = Article.new
        @user = current_user
    end

    def create
        @article = Article.new(params[:article])
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
        if @article.update_attributes(params[:article])
            flash[:success] = "Article updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def index
        @articles = Article.paginate(page: params[:page], :per_page => 20)
    end

    def show
        @article = Article.find(params[:id])
    end

    def destroy
        Article.find(params[:id]).destroy
        flash[:success] = "Article deleted."
        redirect_to articles_path
    end

    private

        def signed_in_user
            unless signed_in?
                store_location
                redirect_to signin_url, notice: "Please sign in."
            end
        end

        def privileged_user
            redirect_to(root_path) unless (current_user.admin? || current_user.author?)
        end

end

