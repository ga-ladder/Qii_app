class ArticlesController < ApplicationController
  include ApplicationHelper

  def index
    @articles = Article.all.includes(:likes, :user).reverse_order
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

  # マイクロポストをいいねする
  def good(user)
    likes.create(user_id: user.id)
  end

  # マイクロポストのいいねを解除する（ネーミングセンスに対するクレームは受け付けません）
  def ungood(user)
    likes.find_by(user_id: user.id).destroy
  end

private
  def article_params
    params.require(:article).permit(:title, :content, images: []).merge(user_id: current_user.id)
  end
end
