class V1::TagsController < ApplicationController
  def search
    if params[:tag_name]
      @tags = Tag.search(params[:tag_name])
      render json: @tags
    end
  end
end
