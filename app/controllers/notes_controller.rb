class NotesController < ApplicationController

  def create
    note = Note.new(note_params)
    if note.save
      redirect_to note_path(note)
    else
      flash[:note_create_error] = "Error creating note"
      render :new
    end
  end

  def new
  end

  def show
    @note = Note.find(params[:id])
    redirect_to user_path(current_user) unless current_user.notes.include?(@note)
  end

  def update
    note = Note.find(params[:id])
      if note.update_attributes(note_params)
        redirect_to note_path(note)
      else
        flash[:note_update_error] = "Error updating note"
        render :edit
      end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private

  def note_params
    params.require(:note).permit(:title, :user_id)
  end

end
