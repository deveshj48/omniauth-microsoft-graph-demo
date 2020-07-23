class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def microsoft_graph
    # Create user, or if already exists, load existing user
    @user = User.from_omniauth_microsoft_graph(request.env["omniauth.auth"])

    # If the user was just created
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Microsoft") if is_navigational_format?
    else
      set_flash_message(:notice, :error, kind: "Microsoft") if is_navigational_format?
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
