module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def signed_in?
		!current_user.nil?
	end
	
	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

    def privileged_user?(user)
        user.admin? || user.author?
    end

#
# Authorization checks for whether current user has permission to visit page.
# (Does user need to be signed in, or have content-authoring privilege?
# In some cases will want to redirect to sign-in page and remember where to
# return to afterward.
#
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

    def signed_in_user
        unless signed_in?
            store_location
            redirect_to signin_url, notice: "Please sign in."
        end
    end

    def privileged_user
        redirect_to(root_path) unless privileged_user?(current_user)
    end
end
