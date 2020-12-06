class Api::V1::UsersController < ApiController
    skip_before_action :authenticate
    
    def signup
        @user = User.new(user_params)
        
        if @user.save
            render json: @user
        else
            render json: {message: @user.errors.full_messages }
        end
            
    end

    def login
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            jwt = Auth.issue({user: user.id})
            render json: {jwt: jwt}
        else
            render json: {message: "Email or password does not match"}
        end
    end

    private
        def user_params
            params.permit(:email, :password, :password_confirmation)
        end
  
end