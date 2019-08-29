class ReviewsController < ApplicationController
before_action :find_car
before_action :find_review, only: [:edit, :update, :destroy]

 def create # POST method for processing form data
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

 def update # PUT method for updating in database
  if @review.update(review_params)
    flash[:success] = "Review was successfully updated!"
    redirect_to car_path(@car)
  else
    render 'edit'
  end
 end

 def new #Create New Obj Review
   @review = Review.new
 end

 def edit #Edit
 end

 def destroy # DELETE method for deleting
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