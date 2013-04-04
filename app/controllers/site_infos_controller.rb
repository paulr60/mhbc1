class SiteInfosController < ApplicationController
    before_filter :signed_in_user
    before_filter :privileged_user
    
	def edit
	end

	def update
        if @site_info.update_attributes(params[:site_info])
            flash[:success] = "Site Info updated"
            redirect_to root_url
        else
            render 'edit'
        end
    end
end
