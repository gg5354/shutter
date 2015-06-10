class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
