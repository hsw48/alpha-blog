class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id

			@email = params[:session][:email]
			@password = params[:session][:password]

			flash[:notice] = "Successfully logged in" 
			redirect_to user
		else 
			flash.now[:alert] = "There was something wrong with your log in details"
			render 'new'
		end

	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged out"
		redirect_to root_path
	end

end
