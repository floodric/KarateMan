class SectionsController < ApplicationController
  before_filter :check_login
  authorize_resource
  
  def index
    @sections = Section.alphabetical.paginate(:page => params[:page]).per_page(8) 
  end

  def show
    @section = Section.find(params[:id])
    @section_students = @section.students.alphabetical
    @registrations = @section.registrations.by_student
    @registration = Registration.new
    @tournament = @section.tournament
  end
  
  def new
    @section = Section.new
  end

  def edit
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(params[:section])
    if @section.save
      # if saved to database
      flash[:notice] = "Successfully created section."
      redirect_to @section # go to show section page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Successfully updated section."
      redirect_to @section
    else
      render :action => 'edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Successfully removed #{@section.name} from karate tournament system"
    redirect_to sections_url
  end

  def final_standings
    @registration = Registration.find(params[:id])
  end

  def save_final_standings
    @registrations = Registration.find(params[:registration_ids])  
    @registrations.each { |r|
      r.update_attributes!(params[:registration].reject{|k,v| v.blank?})
    }
    flash[:notice] = "Added Final Standings!"
    redirect_to section_path(@registrations.first.section)
  end
end