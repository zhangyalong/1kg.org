class ActivitiesController < ApplicationController
  before_filter :login_required, :except => [:index]
  
  def index
    @activities = Activity.find(:all, :conditions => {:done => false})
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

  def show
    @activity = Activity.find(params[:id])
  end
  
end