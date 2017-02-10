class CallingScriptsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  load_and_authorize_resource :prepend => true
  before_action :set_paper_trail_whodunnit
  before_filter :set_uid

  # GET /calling_scripts
  def index
    search = params[:search]
    @calling_scripts =
      smart_listing_create(
        :calling_scripts,
        (search ?
           CallingScript.active.search_by_full_text(search) :
           CallingScript.active),
        partial: "calling_scripts/scripts",
        default_sort: {created_at: "desc"},
        remote: false
      )
    flash[:error] = "No scripts found." if @calling_scripts.empty?
  end

  # GET /calling_scripts/1
  def show
    @markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      filter_html: true,
      no_images: true)
    @address = params[:address]
    if params[:i_called]
      finish_call
    elsif params[:rep_id]
      find_representative_from_id
    elsif @address
      find_representatives_from_location
    end
  end

  # GET /calling_scripts/new
  def new
    @calling_script = CallingScript.new
  end

  # GET /calling_scripts/1/edit
  def edit
  end

  # POST /calling_scripts
  def create
    @calling_script = CallingScript.new(calling_script_params)
    @calling_script.user = @current_user
    if @calling_script.save
      redirect_to script_path(@calling_script),
                  notice: 'Script was successfully created.' 
    else
      render :new 
    end
  end

  # PATCH/PUT /calling_scripts/1
  def update
    if @calling_script.update(calling_script_params)
      redirect_to script_path(@calling_script),
                  notice: 'Script was successfully updated.' 
    else
      render :edit 
    end
  end

  # DELETE /calling_scripts/1
  # DELETE /calling_scripts/1.json
  def destroy
    @calling_script.destroy
    redirect_to scripts_path,
                notice: 'Script was successfully destroyed.' 
  end

  def archive
    @calling_script.update_attribute(:archived, true)
    redirect_to scripts_path,
                notice: 'Script was successfully archived.' 
  end

  private

  def find_representative_from_id
    @representative = Legislator.all_where(
      :bioguide_id => params[:rep_id]
    ).first
  end
  
  def find_representatives_from_location
    @representatives = Legislator.all_for(@address)
    if @representatives.blank?
    flash[:error] =
      "We couldn't find any representatives matching the address you entered."
    end
  end

  def finish_call
    @calling_script.record_call(params[:rep_id], @uid)
    flash[:notice] = "Call completed!"
    next_rep_or_return
  end

  def next_rep_or_return
    if @calling_script.more_reps?(@uid)
      find_representatives_from_location
    else
      redirect_to scripts_path
    end
  end

  def set_uid
    @uid = @current_user.try(:id) || request.remote_ip
  end
  
  # Never trust parameters from the scary internet
  # only allow the white list through.
  def calling_script_params
    params.require(:calling_script).permit(:content, :topic, :summary, :notes)
  end
end
