class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end
  def new
    @article = Article.new
  end
  def edit
    @article = Article.find(params[:id])
  end
  def create
    @article = Article.new(allowed_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new
    end
  end
  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(allowed_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url, notice: "Article was destroyed."
  end
  private
  def allowed_params
    params.require(:article).permit!
  end
end
