class ArticlesController < ApplicationController
    def index
        /articles would have been a local variable/
        /@articles is an instance variable/
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end
end
