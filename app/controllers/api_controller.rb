class ApiController < ActionController::API
    before_action :authenticate 

    def logged_in?
      !!current_user
    end

    def current_user
      if auth_present?
        user = User.find(auth["user"])
        if user
          @current_user ||= user
        end
      end
    end

    def authenticate
        render json: {error: "unauthorized"}, status: 401 unless logged_in?
    end

    def token
        request.headers["HTTP_AUTHORIZATION"].split(" ")[1]
    end
    def auth
        Auth.decode(token)
    end
    def auth_present?
        !!request.headers["HTTP_AUTHORIZATION"]
    end

    
    
end