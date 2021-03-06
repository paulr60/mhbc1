class GalleriesController < ApplicationController
    before_filter :signed_in_user,  only: [:new, :create, :edit, :update, :destroy]
    before_filter :privileged_user, only: [:new, :create, :edit, :update, :destroy]

    def new
        @gallery = Gallery.new
        @photos = Photo.paginate(page: params[:page], :per_page => 40)
    end

    def create
        @gallery = Gallery.new(params[:gallery])
        if @gallery.save
            flash[:success] = "Gallery created"
            redirect_to galleries_path
        else
            @photos = Photo.paginate(page: params[:page], :per_page => 40)
            render 'new'
        end
    end

    def edit
        @photos = Photo.paginate(page: params[:page], :per_page => 40)
        begin
            @gallery = Gallery.find(params[:id])
        rescue
            flash[:error] = "Gallery #{params[:id]} doesn't exist"
            redirect_to galleries_path
        end
    end

    def update
        @gallery = Gallery.find(params[:id])
        if @gallery.update_attributes(params[:gallery])
            flash[:success] = "Gallery updated"
            redirect_to galleries_path
        else
            @photos = Photo.paginate(page: params[:page], :per_page => 40)
            render 'edit'
        end
    end

    def index
        @galleries = Gallery.paginate(page: params[:page], :per_page => 10)
    end

    def show
        begin
            @gallery = Gallery.find(params[:id])
        rescue
            flash[:error] = "Gallery #{params[:id]} doesn't exist"
            redirect_to galleries_path
        end
    end

    def destroy
        Gallery.find(params[:id]).destroy
        flash[:success] = "Gallery deleted."
        redirect_to galleries_path
    end

end
