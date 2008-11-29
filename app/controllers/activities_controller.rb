class ActivitiesController < ApplicationController
  before_filter :login_required, :except => [:index]
  
  def index
    @activities = Activity.find(:all, :conditions => {:done => false, :deleted_at => nil})
  end
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(params[:activity])
    @activity.user = current_user
    @activity.save!
    flash[:notice] = "发布成功"
    redirect_to activities_url
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:id])
    @activity.update_attributes!(params[:activity])
    flash[:notice] = "修改成功"
    redirect_to activity_url(@activity.id)
  end
  
  def destroy
    @activity = Activity.find(params[:id])
    @activity.update_attributes!(:deleted_at => Time.now)
    flash[:notice] = "删除成功"
    redirect_to activities_url
  end
  

  def show
    @activity = Activity.find(params[:id])
    @board = ActivityBoard.find(:first, :conditions => {:activity_id => @activity.id}).board
    @topics = @board.topics.find(:all, :order => "updated_at desc", :limit => 10)
  end
  
end