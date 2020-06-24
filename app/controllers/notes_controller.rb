class NotesController < ApplicationController

  def dashboard
    @notes = current_user.notes.order(created_at: :desc)
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.valid?
      @note.temperature = TemperatureFetch.call(note_params.fetch(:city))
      if @note.temperature.nil?
        flash[:notice] = "Couldn't get temperature for your location, you can set it by editing the note."
      end
      @note.save!
    else
      flash[:notice] = @note.errors.full_messages
    end
    redirect_to dashboard_path
  end

  def delete
    note = current_user.notes.find_by(id: params[:id])
    redirect_to dashboard_path
  end

  def edit
    @note = current_user.notes.find(params[:id])
  end

  def update
    note_id = params["note_id"]
    @note = current_user.notes.find(note_id)
    if @note.update(note_params)
      flash[:notice] = ["Note was updated"]
      redirect_to dashboard_path
    else
      flash[:notice] = @note.errors.full_messages
      redirect_to notes_edit_path(id: note_id)
    end
  end

  private 

   def note_params
      params.permit(:city, :"note_text", :temperature)
   end

end
