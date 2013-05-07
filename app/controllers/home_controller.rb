class HomeController < ApplicationController
  # load_and_authorize_resource

  def index
    if current_user then
      @student = current_user.student
      if current_user.is_admin? then
        ### ADMIN BRANCH

        @student = current_user.student

        # unpaid registrations parital
        @registrations = Registration.unpaid.by_date.by_student.paginate(:page => params[:reg_page]).per_page(10)

        # students without waiver partial
        @needswaiver = Student.needs_waiver

        # upcoming tournament 
        @tournaments = Tournament.upcoming.next(5)

        # finalists partial
        require 'will_paginate/array'
        @done_tournament = Tournament.past.select{|t| t.registrations.select{|r| !r.final_standing.nil?}.size > 0}.first
        if @done_tournament.nil? # no past tournaments with final_standings
          @result_sections=[]
        else # get array of [section,registration list of winners]
          sections = @done_tournament.sections.select{|s| s.registrations.select{|r| !r.final_standing.nil?}.size > 0}
            # only get sections which have registrations with final standing 
          finalists = sections.map{|s| s.registrations.by_final_standing.select{|r| !r.final_standing.nil?} }
            # get only those who have a final standing
          @result_sections = sections.zip(finalists).paginate(:page => params[:res_page], :per_page => 10)
        end

      else
        ### STUDENT BRANCH
        
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
    @query = params[:query]
    @students = Student.search(@query)
    @total_hits = @students.size
  end


end
