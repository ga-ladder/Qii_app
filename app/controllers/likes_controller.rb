class LikesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @article.likes.create(user_id: current_user.id)
  end

  def destroy
    @article = Like.find(params[:id]).article
    @article.uniine(current_user)
  end
end
