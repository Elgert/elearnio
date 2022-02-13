class EnrollmentsController < ApplicationController
  def index
    all_enrollments = Enrollment.includes(:user, :course).all

    render json: all_enrollments
  end

  def create
    course = Course.find_by(public_id: create_params[:course_id])
    user = User.find_by(public_id: create_params[:user_id])

    return not_found unless user && course

    enrollment = Enrollment.new({ course: course, user: user })

    if enrollment.save
      render json: enrollment, status: :created
    else
      render json: { errors: enrollment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    course = Course.find_by(public_id: destroy_params[:course_id])
    user = User.find_by(public_id: destroy_params[:user_id])

    return not_found unless user && course

    enrollment = Enrollment.find_by(course_id: course.id, user_id: user.id)

    return not_found unless enrollment

    if enrollment.destroy
      render json: {}, status: :ok
    else
      render json: { errors: enrollment.errors }, status: 422
    end
  end

  private

  def create_params
    params.require(:enrollment).permit(:user_id, :course_id)
  end

  def destroy_params
    params.require(:enrollment).permit(:user_id, :course_id)
  end
end
