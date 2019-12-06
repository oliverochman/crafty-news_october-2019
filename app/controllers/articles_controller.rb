class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @articles = Article.all
  end

  def show 
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create 
    article = Article.create(article_params)
    
    if article.persisted? 
      redirect_to article, notice: "Article was successfully created."
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
