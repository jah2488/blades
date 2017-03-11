class UsersController < Clearance::UsersController

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
