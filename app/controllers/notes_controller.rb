class NotesController < ApplicationController

  #Probably don't need this.
  # def index
  #   @notes = Note.all
  # end

  def create
    note = Note.new(note_params)
    if note.save
      redirect_to note_path(note)
    else
      flash[:note_create_error] = note.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
  end

  def show
    @note = Note.find(params[:id])
  end

  def update
    note = Note.find(params[:id])
    respond_to do |format|
      if note.update_attributes(note_params)
        format.html { redirect_to note_path(note) }
        # format.js
      else
        flash[:note_update_error] = note.errors.full_messages.to_sentence
        render :edit
      end
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
