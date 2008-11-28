class Admin::BoardsController < Admin::BaseController
  
  def index
    # public board manage page in admin console
    @public_boards = PublicBoard.find(:all, :order => "position asc")
  end
  
  def new
    if params[:type] == "city"
      #setup city board, each geo item ONLY has ONE city board, or has NO city board
      if params[:geo].blank?
        flash[:notice] = "错误"
        redirect_to admin_geos_url
      end
      
      @geo = Geo.find(params[:geo])
      @city_board = CityBoard.new
      render :action => "new_city"
      
    elsif params[:type] == "public"
      #setup pulbic discussion board, only admin can create, assign moderators
      @public_board = PublicBoard.new
      render :action => "new_public"
    end
  end
  
  def create
    if params[:type] == "city"
      # create a city board
      @board = Board.new
      @board.talkable = CityBoard.new(params[:city_board])
      @board.save!
      flash[:notice] = "城市讨论区创建成功"
      redirect_to admin_geos_url
      
    elsif params[:type] == 'public'
      # create a public discussion board, BY admin
      @board = Board.new
      @board.talkable = PublicBoard.new(params[:public_board])
      @board.save!
      flash[:notice] = "开放讨论区创建成功"
      redirect_to admin_boards_url
      
    end
  end
  
  # TODO: create city board for each child geo
  def initial_generate
    
  end
end