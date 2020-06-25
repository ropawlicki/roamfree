class NotesController < ApplicationController
  before_action :check_ownership, except: [:dashboard, :create]

  def dashboard
    @notes = current_user.notes.order(created_at: :desc)
  end

  def create
    @note = current_user.notes.new(create_params)
    if @note.valid?
      @note.temperature = TemperatureFetch.call(@note.city)
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
    note = Note.destroy(params[:id])
    redirect_to dashboard_path
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(update_params)
      flash[:notice] = "Note was updated"
      redirect_to dashboard_path
    else
      flash[:notice] = @note.errors.full_messages
      redirect_to edit_note_path(params[:id])
    end
  end

  private

    def create_params
      params.permit(:city, :"note_text")
    end

   def update_params
      params.require(:note).permit(:city, :"note_text", :temperature)
   end

   def check_ownership
      if Note.find(params[:id]).user != current_user
        flash[:notice] = "You don't have permission to perform this action"
        current_user ? (return redirect_to authenticated_root_path) : (return redirect_to unauthenticated_root_path)
      end
   end

end
