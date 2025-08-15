class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_content
    end
  end

  def destroy
    # find the bookmark to delete
    @bookmark = Bookmark.find(params[:id])
    @list = List.find(params[:list_id])

    if @bookmark.destroy
      redirect_to list_path(@list)
    else
      render 'lists/show', status: :unprocessable_content
    end
  end

  private 

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
