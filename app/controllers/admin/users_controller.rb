class Admin::UsersController < Admin::BaseController
  def index
    @page_title = "管理员&版主设置"
    if params[:type] == "admin"
      @type = "admin"
      render :action => "admin"
    
    
    
    elsif params[:type] == "city"
      @type = "city"
      @geo_roots = Geo.roots
      
      render :action => "city"
      
    else
      @type = "admin"
      render :action => "admin"
    end
  end
  
  def search
    @users = User.find(:all, :conditions => ["email like ? or login like ?", "%#{params[:t]}%", "%#{params[:t]}%"])
    if params[:type] == "admin"
      render :action => "admin"
      
    elsif params[:type] == "city"
      @geo = Geo.find(params[:geo])
      render :template => "admin/geos/edit"
    end
  end
  
  def update
    @user = User.find(params[:id])
    if params[:add] == "admin"
      User.transaction do 
        @user.roles.delete_all
        @user.roles << Role.find_by_identifier("roles.admin")
      end
      redirect_to admin_users_path(:type => "admin")
      
    elsif params[:add] == "city"
      geo = Geo.find(params[:geo]) unless params[:geo].blank?
      board = Board.find(params[:board]) unless params[:board].blank?
      user  = User.find(params[:id]) unless params[:id].blank?
      
      if user && board && geo
        user.roles << Role.find_by_identifier("roles.board.moderator.#{board.id}")
        flash[:notice] = "设置成功"
      else
        flash[:notice] = "系统错误"
      end
      redirect_to edit_admin_geo_url(geo)
      
      
    elsif params[:remove] == "city"
      @geo   = Geo.find(params[:geo]) unless params[:geo].blank?
      @board = Board.find(params[:board]) unless params[:board].blank?
      @user  = User.find(params[:id])
      
      @user.roles.delete(Role.find_by_identifier("roles.board.moderator.#{@board.id}"))
      flash[:notice] = "设置成功"
      redirect_to edit_admin_geo_url(@geo)

      
    elsif params[:remove] == "admin"
      admin_count = User.admins.size
      if admin_count > 1
        @user.roles.delete(Role.find_by_identifier("roles.admin"))
        flash[:notice] = "修改成功"
      elsif admin_count == 1
        flash[:notice] = "只剩最后一位管理员了，不能删除"
      else
        flash[:notice] = "删除错误"
      end
      redirect_to admin_users_path(:type => "admin")
    end
  end
end