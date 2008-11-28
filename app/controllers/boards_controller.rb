class BoardsController < ApplicationController
  def index
    #@cities = CityBoard.find(:all)
    @cities = Board.find(:all, :conditions => "(deleted_at is NULL or deleted_at='') and talkable_type = 'CityBoard'")
    @publics = Board.find(:all, :conditions => "(deleted_at is NULL or deleted_at='') and talkable_type = 'PublicBoard'")
  end
  
  
  def show
    @board = Board.find(params[:id])
    @topics = @board.topics.find(:all, :include => [:user])
    if @board.talkable.class == CityBoard
      @city_board = @board.talkable
      @city = @city_board.geo
      @citizens = @city.users
      render :action => "city"
      
    elsif @board.talkable.class == PublicBoard
      @public_board = @board.talkable
      render :action => "public"
      
    end
  end
  
end