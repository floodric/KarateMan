class DojoStudentsController < ApplicationController
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
    @dojo_student.date = Date.today
    if @dojo_student.save!
      # if saved to database
      flash[:notice] = "Successfully created dojo_student for #{@dojo_student.student.proper_name}."
      redirect_to section_path(@dojo_student.section_id) # go to show section page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @dojo_student = DojoStudent.find(params[:id])
    if @dojo_student.update_attributes(params[:dojo_student])
      flash[:notice] = "Successfully updated dojo_student for #{@dojo_student.student.proper_name}."
      redirect_to @dojo_student
    else
      render :action => 'edit'
    end
  end

  def destroy
    @dojo_student = DojoStudent.find(params[:id])
    dojo_id = @dojo_student.dojo.id
    @dojo_student.destroy
    flash[:notice] = "Successfully removed dojo_student for #{@dojo_student.student.proper_name} from karate tournament system"
    # redirect_to dojo_students_url
    redirect_to section_path(dojo_id) # go to show section page
  end

end
