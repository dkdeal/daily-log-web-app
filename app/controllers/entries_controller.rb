class EntriesController < ApplicationController
  before_action :set_entry, only: [:edit, :update, :destroy]

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    @entry.user = @current_user

    respond_to do |format|
      if @entry.save

        time = Time.new
        date = time.strftime('%m/%d/%Y')
        dateArr = date.split('/')

        format.html { redirect_to daily_path(dateArr[0], dateArr[1], dateArr[2]), notice: 'Entry was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)

        created = @entry.created_at
        date = created.strftime('%m/%d/%Y')
        dateArr = date.split('/')
        
        format.html { redirect_to daily_path(dateArr[0], dateArr[1], dateArr[2]), notice: 'Entry was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy

    created = @entry.created_at
    date = created.strftime('%m/%d/%Y')
    dateArr = date.split('/')

    @entry.destroy
    respond_to do |format|
      format.html { redirect_to daily_path(dateArr[0], dateArr[1], dateArr[2]), notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:content, :user_id)
    end
end
