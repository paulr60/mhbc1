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
        @filter = params[:filter] || 'all'
        @sort = params[:sort] || 'alphabetical'

        fval = case @filter
                    when 'frontpage' then {:frontpage => true}
                    when 'news'      then "menu IS NULL OR menu = '' "
                    when 'menus'     then "menu IS NOT NULL AND menu != '' "
                    when 'drafts'    then {:publish => false }
                end
        sval = case @sort
                    when 'alphabetical' then :title
                    when 'byeditdate'   then :updated_at
                end
        
        if @filter == 'all'
            @articles = Article.order(sval).paginate(page: params[:page], :per_page => 20)
        else
            @articles = Article.where(fval).order(sval).paginate(page: params[:page], :per_page => 20)
        end
#        if params[:filter] == 'frontpage'
#            @articles = Article.where(:frontpage => true).order(:title).paginate(page: params[:page],
#                                                                :per_page => 20)
#        elsif params[:filter] == 'news'
#            @articles = Article.where("menu IS NULL OR menu = '' ").order(:title).paginate(page: params[:page],
#                                                                :per_page => 20)
#        elsif params[:filter] == 'menus'
#            @articles = Article.where("menu IS NOT NULL AND menu != '' ").order(:title).paginate(page: params[:page],
#                                                                :per_page => 20)
#        else    # filter is 'all' or no filter specified
#            @articles = Article.order(:title).paginate(page: params[:page], :per_page => 20)
#        end
#        count = @articles.length
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

