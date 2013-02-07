class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def create
        @photo = Photo.new(params[:photo])
        if @photo.save
            flash[:success] = "Photo created"
            redirect_to photos_path
        else
            render 'new'
        end   	
    end

	def edit
		begin
	        @photo = Photo.find(params[:id])
	    rescue
        	flash[:error] = "Photo #{params[:id]} doesn't exist"
        	redirect_to photos_path
    	end
   	end

	def update
        @photo = Photo.find(params[:id])
        if @photo.update_attributes(params[:photo])
            flash[:success] = "Photo updated"
            redirect_to photos_path
        else
            render 'edit'
        end
	end

	def index
        @photos = Photo.paginate(page: params[:page], :per_page => 40)
	end

	def show
	end

	def destroy
        Photo.find(params[:id]).destroy
        flash[:success] = "Photo deleted."
        redirect_to photos_path
	end
end
