class PostEntriesController < ApplicationController
  # GET /post_entries
  # GET /post_entries.json
  def index
    @post_entries = PostEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_entries }
    end
  end

  # GET /post_entries/1
  # GET /post_entries/1.json
  def show
    @post_entry = PostEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_entry }
    end
  end

  # GET /post_entries/new
  # GET /post_entries/new.json
  def new
    @post_entry = PostEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_entry }
    end
  end

  # GET /post_entries/1/edit
  def edit
    @post_entry = PostEntry.find(params[:id])
  end

  # POST /post_entries
  # POST /post_entries.json
  def create
    @post_entry = PostEntry.new(params[:post_entry])

    respond_to do |format|
      if @post_entry.save
        format.html { redirect_to @post_entry, notice: 'Post entry was successfully created.' }
        format.json { render json: @post_entry, status: :created, location: @post_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @post_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_entries/1
  # PUT /post_entries/1.json
  def update
    @post_entry = PostEntry.find(params[:id])

    respond_to do |format|
      if @post_entry.update_attributes(params[:post_entry])
        format.html { redirect_to @post_entry, notice: 'Post entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_entries/1
  # DELETE /post_entries/1.json
  def destroy
    @post_entry = PostEntry.find(params[:id])
    @post_entry.destroy

    respond_to do |format|
      format.html { redirect_to post_entries_url }
      format.json { head :no_content }
    end
  end
end
