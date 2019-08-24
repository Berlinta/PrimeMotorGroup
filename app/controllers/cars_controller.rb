class CarsController < ApplicationController
  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :redirect_if_car_nonexistent!, only: [:show]

 def index
    if params[:line].blank?
    @cars = Car.all.order("created_at DESC")
  else
    @line_id = Line.find_by(name: params[:line]).id
    @cars = Car.where(:line_id => @line_id).order("created_at DESC")
  end
 end

 def create
  @car = Car.new(car_params)
    @car.user_id = current_user.id
      if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
 end

 def update
  if @car.update(car_params)
    redirect_to car_path(@car)
  else
    render 'edit'
  end
 end

 def destroy
  @car.destroy
  redirect_to cars_path
 end

 def show
 end

 def edit
 end

 def new
  @car = Car.new
 end

 def car_make
  @cars = Car.car_make
  render 'car_make'
 end

 def reviewed
  @cars = Car.reviewed
  render action: :index
 end

 private

def car_params
  params.require(:car).permit(:name, :description, :drive, :make, :line_id)
end

def find_car
  @car = Car.find_by(id: params[:id])
end

def redirect_if_car_nonexistent!
    if @car.nil?
      flash[:message] = 'Car Does Not Exist!'
      redirect_to cars_path
    end
  end

def authenticate_user!
  if @car.user_id != current_user.id
    redirect_to cars_path
  end
end

end