class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  # GET /shifts.json
  # def index
  #   @shifts = Shift.all
  # end

  # GET /semesters/:semester_id/shifts/:id(.:format) 
  # GET /shifts/1.json
  def show
    @semester = Semester.find(session[:semester]["id"])
    @shift = Shift.find(params["id"])
    @shift_users = @shift.users.all
  end

  # GET /semesters/:semester_id/shifts/new(.:format)
  def new
    @shift = Shift.new
    @semester = Semester.find(session[:semester]["id"])
  end

  # GET /semesters/:semester_id/shifts/:id/edit(.:format)
  def edit
    @semester = Semester.find(session[:semester]["id"])
  end

  # POST /semesters/:semester_id/shifts(.:format) 
  # POST /shifts.json
  def create
    @semester = Semester.find(session[:semester]["id"])
    @shift = @semester.shifts.create(shift_params)
    flash[:notice] = "#{@shift.description} @ #{@shift.location} was successfully created."
    redirect_to semester_path(@semester)
    
    # @shift = Shift.new(shift_params)

    # respond_to do |format|
    #   if @shift.save
    #     format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
    #     format.json { render :show, status: :created, location: @shift }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @shift.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  # PATCH/PUT /semesters/:semester_id/shifts/:id(.:format)
  def update
    @semester = Semester.find(session[:semester]["id"])
    @shift = Shift.find params[:id]
    @shift.update_attributes!(shift_params)
    flash[:notice] = "#{@shift.description} @ #{@shift.location} was successfully updated."
    redirect_to semester_path(@semester)
  end
  # def update
  #   respond_to do |format|
  #     if @shift.update(shift_params)
  #       format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @shift }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @shift.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /semesters/:semester_id/shifts/:id(.:format)
  # DELETE /shifts/1.json
  def destroy
    @semester = Semester.find(session[:semester]["id"])
    @shift = Shift.find params[:id]
    @shift.destroy
    redirect_to semester_path(@semester)
    # respond_to do |format|
    #   format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end
  
  def add_new_shift_user
    @shift = Shift.find params[:id]
    @user = User.where(:email => params[:shift][:users]).first
    @shift.users << @user
    redirect_to(semester_shift_path(@shift))
  end
  
  def delete_new_shift_user
    @shift = Shift.find params[:id]
    @user = User.find params[:user_id]
    @shift.users.destroy(@user)
    redirect_to(semester_shift_path(@shift))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:description, :location, :time, :day, :semester)
    end
end
