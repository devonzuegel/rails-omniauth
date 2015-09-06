# app/controllers/entries_controller.rb
class EntriesController < ApplicationController
  before_action :set_entry, except: [:index, :new, :create]

  # GET /entries
  # GET /entries.json
  def index
    filter = params['filter'] || 'default'
    @entries = Entry.filter(visitor: current_visitor, filter: filter)
    @api_key = current_visitor.api_key
    respond_to do |format|
      format.html
      format.json { render json: @entries, status: :ok }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    check_permissions :read
  end

  # GET /entries/new
  def new
    redirect_to root_path
  end

  # GET /entries/1/freewrite
  def freewrite
    check_permissions :write
    redirect_to @entry unless @entry.body.blank?
  end

  # GET /entries/1/edit
  def edit
    check_permissions :write
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    respond_to do |format|
      if @entry.save
        format.html { redirect_to freewrite_entry_path(@entry) }
        format.json { render json: @entry, status: :created, location: @entry }
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
    check_permissions :write
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
    check_permissions :write
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { render json: 'Deleted successfully', status: :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between
  # actions.
  def set_entry
    @entry = Entry.find(params[:id]) if params[:id]
  end

  def check_permissions(mode = :read)
    case mode
    when :write then redirect_to entries_url unless @entry.owned_by?(_visitor: current_visitor)
    else             redirect_to entries_url unless @entry.visible_to?(_visitor: current_visitor)
    end
  end

  # Never trust parameters from the scary internet, only allow
  # the white list through.
  def entry_params
    params.require(:entry).permit(:title, :body, :scope).merge(user: current_user,
                                                               public: public?,
                                                               visitor: current_visitor)
  end

  def public?
    current_user.nil? ? true : current_user.account.public_posts
  end
end
