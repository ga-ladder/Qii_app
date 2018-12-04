class ArticlesController < ApplicationController
  include ApplicationHelper

  def index
    @articles = Article.all.reverse_order
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'created new article!'
      redirect_to article_path(@article)
    else
      flash[:alart] = 'faild to create new artcle...'
    end
  end

  def edit
    @article = Article.find(params[:id])
    render :new
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
      flash[:notice] = 'updated the article!'
    else
      flash[:alart] = 'faild ...'
    end
  end

  def preview_markdown
    @markdown = qiita_markdown(params[:text])
    respond_to do |format|
      format.json
      format.text { render text: @markdown }
    end
  end

private
  def article_params
    params.require(:article).permit(:title, :content, images: []).merge(user_id: current_user.id)
  end
end
