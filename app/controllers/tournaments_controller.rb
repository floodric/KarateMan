class TournamentsController < ApplicationController
  # load_and_authorize_resource
  before_filter :check_login
  authorize_resource
  
  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_tournaments = Tournament.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @tournament = Tournament.find(params[:id])
    @sections = @tournament.sections.active.paginate(:page => params[:page]).per_page(5)

    if @tournament.date < Date.today # tournament over, show results
      require 'will_paginate/array'
      @done_tournament = @tournament
      if @done_tournament.nil? # no past tournaments with final_standings
        @result_sections=[]
      else # get array of [section,registration list of winners]
        sections = @done_tournament.sections.select{|s| s.registrations.select{|r| !r.final_standing.nil?}.size > 0}
          # only get sections which have registrations with final standing 
        finalists = sections.map{|s| s.registrations.by_final_standing.select{|r| !r.final_standing.nil?} }
          # get only those who have a final standing
        @result_sections = sections.zip(finalists).paginate(:page => params[:res_page], :per_page => 10)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.json
  def new
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(params[:tournament])

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Successfully created '+@tournament.name+'.' }
        format.json { render json: @tournament, status: :created, location: @tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.json
  def update
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to @tournament, notice: 'Successfully updated '+@tournament.name+'.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end
end
