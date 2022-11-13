class MainController < ApplicationController
  def initialize
  end

  def index
  end

  def new
  end

  def create
  end

  def search
    pp "search"
    @kondateList = Search.searchApi(params[:keyWord])
    @keyWord = params[:keyWord]
    pp @kondateList[0]["title"]
    pp "↑おわり"
    @msg = "こんにちは。お久しぶりです。"
    render :index
  end
end
