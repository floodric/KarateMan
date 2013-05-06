class HomeController < ApplicationController
  # load_and_authorize_resource
  
  def index
    if current_user then
      @student = current_user.student
      if current_user.is_admin? then
        @student = current_user.student
        @registrations = Registration.by_date.paginate(:page => params[:page]).per_page(10)
      else
        @dojo_history = @student.dojo_students.chronological.paginate(:page => params[:dojo_page]).per_page(10)
        @registrations = @student.registrations.by_event_name.paginate(:page => params[:reg_page]).per_page(10)
      end
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end
end
