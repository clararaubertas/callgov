class CallingScriptsController < ApplicationController

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  load_and_authorize_resource

  # GET /calling_scripts
  def index
    @calling_scripts = smart_listing_create(:calling_scripts, CallingScript.all, partial: "calling_scripts/script", default_sort: {calls_count: "desc"})
    @request = request
  end

  # GET /calling_scripts/1
  def show
    @request = request
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, filter_html: true, no_images: true)
    if params[:i_called]
      finish_call
    elsif params[:rep_id]
      find_representative_from_id
    elsif params[:address]
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
        redirect_to script_path(@calling_script), notice: 'Calling script was successfully created.' 
    else
      render :new 
    end
  end

  # PATCH/PUT /calling_scripts/1
  def update
    if @calling_script.update(calling_script_params)
      redirect_to script_path(@calling_script), notice: 'Calling script was successfully updated.' 
    else
      render :edit 
    end
  end

  # DELETE /calling_scripts/1
  # DELETE /calling_scripts/1.json
  def destroy
    @calling_script.destroy
    redirect_to scripts_path, notice: 'Calling script was successfully destroyed.' 
  end

  private

  def find_representative_from_id
    @representative = Sunlight::Legislator.all_where(:bioguide_id => params[:rep_id]).first
  end
  
  def find_representatives_from_location
    @representatives = Sunlight::Legislator.all_for(:address => params[:address])
    if @representatives.blank?
      flash[:error] = "We couldn't find any representatives matching the address you entered."
    end
  end

  def finish_call
    @id = @current_user.try(:id)
    @ip = request.remote_ip
    @calling_script.record_call(params[:rep_id], @id || @ip)
    flash[:notice] = "Call completed!"
    next_rep_or_return
  end

  def next_rep_or_return
    if Call.find(:all, conditions: { calling_script_id: @calling_script.id, user_id: (@id || @ip)}).size < 3
      find_representatives_from_location
    else
      redirect_to scripts_path
    end
  end
  
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
  def calling_script_params
    params.require(:calling_script).permit(:content, :topic, :summary, :notes)
  end
end
