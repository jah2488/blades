class UsersController < Clearance::UsersController


  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash[:alert] = "User couldn't be created, check your email and password."
      if request.referrer =~ /join/
        render template: "games/join"
      else
        render template: "users/new"
      end
    end
  end


  def user_from_params
    email    = user_params.delete(:email)
    password = user_params.delete(:password)
    current_game_id = user_params.delete(:current_game_id)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.current_game_id = current_game_id
    end
  end
end
