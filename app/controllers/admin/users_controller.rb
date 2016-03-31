class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(status: params[:status]).order(:id)
  end

  def update
    @user = User.find(params[:id])

    @user.update(user_params)
    flash[:info] = "User ID: #{@user.id} has been updated."
    redirect_to admin_users_path(status: @user.status)
  end

  def show
    @reservations = Reservation.all
  end

  private
  def user_params
    params.require(:user).permit(:status)
  end
end
