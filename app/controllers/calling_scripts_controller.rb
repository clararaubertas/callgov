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
      @calling_script.record_call(params[:rep_id], @current_user.try(:id) || request.remote_ip)
      flash[:notice] = "Call completed!"
      if Call.find(:all, conditions: { calling_script_id: @calling_script.id, user_id: (@current_user.try(:id) || request.remote_ip)}).size < 3 
      @representatives = Sunlight::Legislator.all_for(:address => params[:address])
      else
        redirect_to calling_scripts_path
      end
    elsif params[:rep_id]
      @representative = Sunlight::Legislator.all_where(:bioguide_id => params[:rep_id]).first
    elsif params[:address]
      @representatives = Sunlight::Legislator.all_for(:address => params[:address])
      if @representatives.empty?
        flash[:error] = "We couldn't find any representatives matching the address you entered."
      end
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
  # POST /calling_scripts.json
  def create
    @calling_script = CallingScript.new(calling_script_params)
    @calling_script.user = @current_user
    respond_to do |format|
      if @calling_script.save
        format.html { redirect_to @calling_script, notice: 'Calling script was successfully created.' }
        format.json { render :show, status: :created, location: @calling_script }
      else
        format.html { render :new }
        format.json { render json: @calling_script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calling_scripts/1
  # PATCH/PUT /calling_scripts/1.json
  def update
    respond_to do |format|
      if @calling_script.update(calling_script_params)
        format.html { redirect_to @calling_script, notice: 'Calling script was successfully updated.' }
        format.json { render :show, status: :ok, location: @calling_script }
      else
        format.html { render :edit }
        format.json { render json: @calling_script.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calling_scripts/1
  # DELETE /calling_scripts/1.json
  def destroy
    @calling_script.destroy
    respond_to do |format|
      format.html { redirect_to calling_scripts_url, notice: 'Calling script was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def calling_script_params
      params.require(:calling_script).permit(:content, :topic, :summary, :notes)
    end
end
