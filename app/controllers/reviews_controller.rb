class ReviewsController < ApplicationController

before_action :find_car
before_action :find_review, only: [ :edit, :update, :destroy]

 def create
  @review = Review.new(review_params)
  @review.car_id = @car.id
  @review.user_id = current_user.id
    if @review.save
      redirect_to car_path(@car)
    else
      flash[:error] = "A review is required!"
      render :new
    end
 end

 def update
  if @review.update(review_params)
    flash[:success] = "Review was successfully updated!"
    redirect_to car_path(@car)
  else
    render 'edit'
  end
 end

 def new
   @review = Review.new
 end

 def edit
 end

 def destroy
   @review.destroy
   redirect_to cars_path
  end
 end

 private #Private Methods

  def review_params
    params.require(:review).permit(:comment)
  end

  def find_car
    @car = Car.find(params[:car_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end