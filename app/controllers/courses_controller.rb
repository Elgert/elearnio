class CoursesController < ApplicationController
  def index
    all_courses = Course.all

    render json: all_courses
  end

  def show
    course = Course.find_by(public_id: params[:id])

    return not_found unless course

    render json: course, status: :ok
  end

  def create
    course = Course.new(create_params)
    author = User.find_by(public_id: create_params[:author_id])

    return not_found unless author

    course.update(author_id: author.id)

    if course.save
      render json: course, status: :created
    else
      render json: { errors: course.errors }, status: :unprocessable_entity
    end
  end

  def update
    course = Course.find_by(public_id: params[:id])
    author = User.find_by(public_id: create_params[:author_id])

    return not_found unless course && author

    if course.update(update_params.merge(author_id: author.id))
      render json: course, status: :ok
    else
      render json: { errors: course.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    course = Course.find_by(public_id: params[:id])

    return not_found unless course

    if course.destroy
      render json: {}, status: :ok
    else
      render json: { errors: course.errors }, status: 422
    end
  end

  private

  def create_params
    params.require(:course).permit(:name, :description, :category, :author_id)
  end

  def update_params
    params.require(:course).permit(:name, :description, :category, :author_id)
  end
end
