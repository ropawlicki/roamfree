class NotesController < ApplicationController
  before_action :check_ownership, except: [:index, :create]

  def index
    @notes = current_user.notes.order(created_at: :desc)
    @new_note = Note.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      @note.update(temperature: TemperatureFetch.call(@note.city))
      flash[:notice] = "Couldn't get temperature for your location, set it with edit" if @note.temperature.nil?
    else
      flash[:notice] = @note.errors.full_messages
    end
    redirect_to index_path
  end

  def delete
    Note.destroy(params[:id])
    redirect_to index_path
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to index_path, notice: 'Note was updated'
    else
      redirect_to edit_note_path(params[:id]), notice: @note.errors.full_messages
    end
  end

  private

  def note_params
    params.require(:note).permit(:city, :note_text, :temperature)
  end

  def check_ownership
    redirect_to authenticated_root_path if Note.find(params[:id]).user != current_user
  end
end
