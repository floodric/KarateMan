class DojoStudentsController < ApplicationController
  before_filter :check_login
  authorize_resource
  
  def index
    @dojo_students = DojoStudent.by_student.paginate(:page => params[:page]).per_page(8)
  end

  def show
    @dojo_student = DojoStudent.find(params[:id])
  end
  
  def new
    if params[:from]=="student" then 
      @student = Student.find(params[:id])
      if @student.current_dojo.nil?
      @last = nil
      else
        # find last assignment
        @last = @student.dojo_students.select{|ds| ds.end_date.nil?}.first
      end
    elsif params[:from]=="dojo" then @dojo = Student.find(params[:id])
    end
    @dojo_student = DojoStudent.new
  end

  def edit

    @dojo_student = DojoStudent.find(params[:id])
  end

  def create
    @dojo_student = DojoStudent.new(params[:dojo_student])
    @dojo_student.start_date ||= Date.today
    if @dojo_student.save!
      # if saved to database
      flash[:notice] = "Successfully created dojo_student for #{@dojo_student.student.proper_name}."
      redirect_to student_path(@dojo_student.student_id) # go to show section page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo_student = DojoStudent.find(params[:id])
    if @dojo_student.update_attributes(params[:dojo_student])
      flash[:notice] = "Changed #{@dojo_student.student.proper_name}'s' study at #{@dojo_student.dojo.name} dojo"
      redirect_to student_path(@dojo_student.student_id)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo_student = DojoStudent.find(params[:id])
    student_id = @dojo_student.student.id
    @dojo_student.end_date = Date.today
    @dojo_student.save!
    flash[:notice] = "Ended #{@dojo_student.student.proper_name}'s' study at #{@dojo_student.dojo.name} dojo"
    # redirect_to dojo_students_url
    redirect_to student_path(student_id) # go to show section page
  end

end
