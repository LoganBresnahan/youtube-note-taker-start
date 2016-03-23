class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def create
    video = Video.new(video_params)
    if video.save
       redirect_to note_path(video.note_id)
    else
      flash[:video_create_error] = video.errors.full_messages.to_sentence
      redirect_to note_path(video.note_id)
    end
  end

  def new
  end

  def update
    video = Video.find(params[:id])
    if user.update_attributes(video_params)
      redirect_to note_path(@note)
    else
      flash[:video_update_error] = video.errors.full_messages.to_sentence
      render :edit
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def destroy
    Video.find(params[:id]).destroy
    #redirect_to
  end

  private

  def video_params
    params.require(:video).permit(:title, :link, :note_id)
  end

end
