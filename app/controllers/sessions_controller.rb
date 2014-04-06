class SessionsController < ApplicationController

	def new 
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			## correct entry
			sign_in user
			redirect_to user
		else
			## incorrect with error
			flash.now[:danger] = "Invalid email/password combination" # flash.now is quite correct causes flash to be immediately dropped on an additional request, vs next request
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end


end
