class CallingScriptsController < ApplicationController
  load_and_authorize_resource


  # GET /calling_scripts
  # GET /calling_scripts.json
  def index
    @calling_scripts = CallingScript.all
  end

  # GET /calling_scripts/1
  # GET /calling_scripts/1.json
  def show
    if params[:rep_id]
      @representative = Sunlight::Legislator.all_where(:bioguide_id => params[:rep_id]).first
      @substitutions = {:representative => "#{@representative.first_name} #{@representative.last_name}", :constituent => params[:name], :city => params[:address]}
    elsif params[:address]
      @representatives = Sunlight::Legislator.all_for(:address => params[:address])
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
      params.require(:calling_script).permit(:content, :topic, :summary)
    end
end
