class UsersController < ApplicationController
  def index
    all_users = User.all

    render json: all_users
  end

  def show
    user = User.find_by(public_id: params[:id])

    return not_found unless user

    render json: user, status: :ok
  end

  def create
    user = User.new(create_params)

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(public_id: params[:id])

    return not_found unless user

    if user.update(update_params)
      render json: user, status: :ok
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(public_id: params[:id])

    return not_found unless user

    if user.destroy
      render json: {}, status: :ok
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private

  def create_params
    params.require(:user).
           permit(:first_name, :last_name, :email)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
