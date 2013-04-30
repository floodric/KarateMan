class DojosController < ApplicationController
  # GET /dojos
  # GET /dojos.json
  def index
    @dojos = Dojo.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_dojos = Dojo.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dojos }
    end
  end

  # GET /dojos/1
  # GET /dojos/1.json
  def show
    require 'will_paginate/array'
    @dojo = Dojo.find(params[:id])
    @dojo_students = (@dojo.current_students.select{|s| s.active==true}).paginate(:page => params[:page], per_page: 5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dojo }
    end
  end

  # GET /dojos/new
  # GET /dojos/new.json
  def new
    @dojo = Dojo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dojo }
    end
  end

  # GET /dojos/1/edit
  def edit
    @dojo = Dojo.find(params[:id])
  end

  # POST /dojos
  # POST /dojos.json
  def create
    @dojo = Dojo.new(params[:dojo])

    respond_to do |format|
      if @dojo.save
        format.html { redirect_to @dojo, notice: 'Dojo was successfully created.' }
        format.json { render json: @dojo, status: :created, location: @dojo }
      else
        format.html { render action: "new" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dojos/1
  # PUT /dojos/1.json
  def update
    @dojo = Dojo.find(params[:id])

    respond_to do |format|
      if @dojo.update_attributes(params[:dojo])
        format.html { redirect_to @dojo, notice: 'Dojo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dojos/1
  # DELETE /dojos/1.json
  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy

    respond_to do |format|
      format.html { redirect_to dojos_url }
      format.json { head :no_content }
    end
  end
end
