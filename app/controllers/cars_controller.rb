class CarsController < ApplicationController
  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :redirect_if_car_nonexistent!, only: [:show]

 def index  #GET method all cars database   
    #byebug
    if params[:line].blank?
    @cars = Car.all.order("created_at DESC")
  else
    #byebug
    @line_id = Line.find_by(name: params[:line]).id
    @cars = Car.where(:line_id => @line_id).order("created_at DESC")
  end
 end

 def create # POST method for processing form data
  @car = Car.new(car_params)
    @car.user_id = current_user.id
      if @car.save
      flash[:success] = "#{@car.name} your car was added."
      redirect_to car_path(@car)
    else
      flash[:error] = "#{@car.errors.full_messages.to_sentence}."
      render :new
    end
 end

 def update # PUT method for updating in database
  if @car.update(car_params)
    flash[:success] = "#{@car.name} was updated."
    redirect_to car_path(@car)
  else
    render 'edit'
  end
 end

 def destroy # DELETE method for deleting
  @car.destroy
  flash[:success] = "#{@car.name} your car was removed."
  redirect_to cars_path
 end

 def show #Show
 end

 def edit #Edit
 end

 def new #Create New Obj Car
  @car = Car.new
 end

 def car_make #Scope
  @cars = Car.car_make
  render 'car_make'
 end

 def reviewed #Scope
  @cars = Car.reviewed
  render action: :index
 end

 private #Private Methods

 def car_params #strong parameters for the validation of params
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