# app/controllers/entries_controller.rb
class EntriesController < ApplicationController
  before_action :set_entry

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.visible_to(current_user)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    redirect_to root_path
  end

  # GET /entries/1/freewrite
  def freewrite
    redirect_to @entry unless @entry.body.blank?
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new entry_params
    @entry.user = current_user
    @entry.public = current_user.account.public_posts if current_user

    respond_to do |format|
      if @entry.save
        format.html { redirect_to freewrite_entry_path @entry }
        format.json { render :show, status: :created, location: @entry }
      else
        msg = @entry.errors.full_messages
        format.html { redirect_to :back, flash: { error: msg } }
        format.json { render json: msg, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      entry_params[:body].squeeze!
      if @entry.update(entry_params)
        format.html { redirect_to @entry }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between
  # actions.
  def set_entry
    @entry = Entry.find(params[:id]) if params[:id]
  end

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def entry_params
    params.require(:entry).permit(:title, :body)
  end
end
