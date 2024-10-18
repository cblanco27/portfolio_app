class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @search_params = params[:search] || {}
    
    
    if @search_params.present?
      @students = Student.all
      
      if params[:major] == "" && params[:expected_graduation_date] == "" && params[:graduation_date_select] == ""
        flash[:alert] = "Please enter search criteria to find students"
        render index
      end

      if @search_params[:major].present?
        @students = @students.where(major: @search_params[:major])
      end

      #Allows user input to filter by major, graduation date before or after, or by both types. M04
      if @search_params[:expected_graduation_date].present? && @search_params[:graduation_date_select].present?
        date = Date.parse(@search_params[:expected_graduation_date])
        if @search_params[:graduation_date_select] == "Before"  
          @students = @students.where(graduation_date: ...date)
        elsif  @search_params[:graduation_date_select] == "After"
          @students = @students.where(graduation_date: date...)
        end #.. covers a range, being placed before date allows range before date, after gives range after 3 ... means inclusive
      end

      @students
    #allows the show all button to work 
    elsif !!params[:show_all] == true
      @students = Student.all
      #returns nothing if no search parameters are entered M04
    else
      @students = Student.none
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_email, :major, :minor, :graduation_date, :profile_pic)
    end
end
