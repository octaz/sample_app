class SessionsController < ApplicationController

	def new 
	end

	def create
		user = User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
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
## form_for for sign in (original version)
# <%= form_for(:session, url: sessions_path) do |f| %>

# 			<%= f.label :email %>
# 			<%= f.text_field :email %>

# 			<%= f.label :password %>
# 			<%= f.password_field :password %>

# 			<%= f.submit "Sign In", class: "btn btn-large btn-primary" %>