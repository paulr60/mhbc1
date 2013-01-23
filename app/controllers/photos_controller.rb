class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end

	def create
        @photo = Photo.new(params[:photo])
        if @photo.save
            flash[:success] = "Photo created"
            redirect_to root_path
        else
            render 'new'
        end   	
    end

	def edit
        @photo = Photo.find(params[:id])
   	end

	def update
        @photo = Photo.find(params[:id])
        if @photo.update_attributes(params[:photo])
            flash[:success] = "Photo updated"
            redirect_to root_path
        else
            render 'edit'
        end
	end

	def index
	end

	def show
	end

	def destroy
	end
end
